import 'dart:io';

import 'package:dio/dio.dart';

import '../common.dart';

abstract class BaseApiClient {
  Dio service = DioHelper.currentDio();
  final HttpConfig _config = DioHelper.getConf();
  final ErrorMessageDelegate _errorText = DioHelper.errorText;

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseResp<T> Return status code msg data .
  Future<BaseResp<T>> request<T>(
    String method,
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
    required dynamic Function(dynamic) onDeserialize,
    Options? options,
    Function(int, int)? onSendProgress,
    bool decodeJson = false,
  }) async {
    service.options.method = method;
    LogUtil.d("Request: M: $method P: $path");

    try {
      final response = await service.request<dynamic>(path,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress);
      DioHelper.printHttpLog(response);
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        return BaseResp.dataFromJson(
          json: response.data,
          onDeserialize: onDeserialize,
          statusCode: response.statusCode ?? -1,
          response: response,
          decodeJson: decodeJson,
        );
      } else {
        String errMessage = DioHelper.onErrorHandle(response);
        return BaseResp.withError(
          statusCode: response.statusCode ?? -1,
          errorMsg: errMessage,
          response: response,
        );
      }
    } catch (error) {
      return _handleError<T>(error);
    }
  }

  /// Make http request with http Config.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseResp<T> status code msg data .
  Future<BaseResp<T>> requestWithConfig<T>(
    String method,
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
    required dynamic Function(dynamic) onDeserialize,
    Options? options,
  }) async {
    service.options.method = method;
    try {
      Response response = await service.request<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
      );
      int stt;
      String msg;
      dynamic dt;
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        try {
          if (response.data is Map) {
            stt = (response.data[_config.status] is int)
                ? response.data[_config.status] as int
                : int.tryParse(response.data[_config.status].toString()) ?? -1;
            msg = response.data[_config.msg].toString();
            dt = response.data[_config.data];
          } else {
            Map<String, dynamic> dataMap = DioHelper.decodeData(response);
            stt = (dataMap[_config.status] is int)
                ? dataMap[_config.status] as int
                : int.tryParse(response.data[_config.status].toString()) ?? -1;
            msg = dataMap[_config.msg].toString();
            dt = dataMap[_config.data];
          }
          BaseResp<T> resp = BaseResp.dataFromJson(
            json: dt,
            onDeserialize: onDeserialize,
            statusCode: stt,
            response: response,
          );
          resp.errorMsg = msg;
          return resp;
        } catch (e) {
          String errMessage = DioHelper.onErrorHandle(response);
          return BaseResp.withError(
            statusCode: response.statusCode ?? -1,
            errorMsg: errMessage,
            response: response,
          );
        }
      } else {
        String errMessage = DioHelper.onErrorHandle(response);
        return BaseResp.withError(
          statusCode: response.statusCode ?? -1,
          errorMsg: errMessage,
          response: response,
        );
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  BaseResp<T> _handleError<T>(dynamic error) {
    String errorDetails = error.toString();
    if (error is DioException) {
      String errMessage = _errorText.somethingWentWrong;
      int status = error.response?.statusCode ?? -1;
      switch (error.type) {
        case DioExceptionType.connectionError:
          errMessage = _errorText.noInternetConnection;
          status = status408RequestTimeout;
          break;
        case DioExceptionType.connectionTimeout:
          errMessage = _errorText.requestTimeOut;
          status = status408RequestTimeout;
          break;
        case DioExceptionType.sendTimeout:
          errMessage = _errorText.sendTimeOut;
          status = status408RequestTimeout;
          break;
        case DioExceptionType.receiveTimeout:
          errMessage = _errorText.unableToConnectTheServer;
          break;
        case DioExceptionType.badCertificate:
          errMessage = _errorText.incorrectCertificateAsConfigured;
          break;
        case DioExceptionType.cancel:
          errMessage = _errorText.requestCancelled;
          break;
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            errMessage = _errorText.noInternetConnection;
            status = status408RequestTimeout;
          } else {
            errMessage = DioHelper.onErrorHandle(error.response?.data);
          }
          break;
      }

      if (errMessage.isEmpty && error.message != null) {
        errMessage = error.message!;
      }
      LogUtil.e("$errMessage: $errorDetails");
      return BaseResp.withError(
        statusCode: status,
        errorMsg: errMessage,
        response: error.response,
      );
    }

    if (error is SocketException) {
      LogUtil.e("No Internet connection: $errorDetails");
      return BaseResp.withError(
        statusCode: status408RequestTimeout,
        errorMsg: _errorText.noInternetConnection,
      );
    }
    if (error is HttpException) {
      LogUtil.e("Couldn't find the: $errorDetails");
      return BaseResp.withError(
        statusCode: -1,
        errorMsg: _errorText.couldNotFindTheRequest,
      );
    }
    if (error is FormatException) {
      LogUtil.e("Bad response format: $errorDetails");
      return BaseResp.withError(
        statusCode: -1,
        errorMsg: _errorText.badResponseFormat,
      );
    }
    LogUtil.e("Unknown error: $errorDetails");
    return BaseResp.withError(
      statusCode: -1,
      errorMsg: "Something went wrong: $errorDetails",
    );
  }
}
