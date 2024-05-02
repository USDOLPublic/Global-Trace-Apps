import 'dart:convert';

import 'package:dio/dio.dart';
import '../common.dart';

class BaseResp<T> {
  T? data;
  String? errorMsg;
  int statusCode;
  Response? response;

  BaseResp({
    this.data,
    this.statusCode = -1,
    this.errorMsg = "",
    this.response,
  });

  factory BaseResp.dataFromJson({
    required dynamic json,
    required dynamic Function(dynamic) onDeserialize,
    int statusCode = -1,
    Response? response,
    bool decodeJson = false,
  }) {
    if (decodeJson && json is String) {
      json = jsonDecode(json);
    }
    var resp = BaseResp<T>(
      response: response,
      statusCode: statusCode,
    );
    try {
      if (json is Map<String, dynamic>) {
        resp.data = onDeserialize(json) as T;
      } else if (json is List) {
        resp.data = onDeserialize(json) as T;
      } else if (T == bool ||
          T == String ||
          T == int ||
          T == double ||
          T == Map) {
        // primitives
        resp.data = json as T?;
      } else {
        resp.data = json as T;
      }
    } catch (error) {
      LogUtil.e("${T.toString()} Data parsing exception...! => $error");
      resp.data = null;
      resp.errorMsg = error.toString();
      throw const FormatException();
    }
    return resp;
  }

  factory BaseResp.withError({
    required String errorMsg,
    int statusCode = -1,
    Response? response,
  }) =>
      BaseResp(
        data: null,
        errorMsg: errorMsg,
        statusCode: statusCode,
        response: response,
      );

  factory BaseResp.withData({
    required T data,
    String errorMsg = "",
    int statusCode = -1,
    Response? response,
  }) =>
      BaseResp(
        data: data,
        errorMsg: errorMsg,
        statusCode: statusCode,
        response: response,
      );

  bool isSuccess() {
    return (errorMsg == null || errorMsg!.isEmpty) &&
        statusCode >= 200 &&
        statusCode < 300;
  }

  bool isHaveRespData() {
    return isSuccess() && data != null;
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"status\":\"$statusCode\"");
    sb.write(",\"msg\":\"$errorMsg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }

  String _getErrorMessage(dynamic errorObj) {
    if (errorObj == null || errorObj is! Map<String, dynamic>) {
      return "";
    }
    String messKey = "message";
    if (errorObj[messKey] == null) {
      messKey = "messages";
    }
    if (errorObj[messKey] != null) {
      if (errorObj[messKey] is String) {
        return errorObj[messKey].toString();
      } else if (errorObj[messKey] is List &&
          (errorObj[messKey] as List).isNotEmpty) {
        return (errorObj[messKey] as List).first.toString();
      }
    }
    List<String> keyErrors = errorObj.keys.toList();
    if (keyErrors.isNotEmpty) {
      for (String key in keyErrors) {
        if (errorObj[key] != null) {
          String errorMessage = _getErrorMessage(errorObj[key]);
          if (errorMessage.isNotEmpty) {
            return errorMessage;
          }
        }
      }
    }
    return "";
  }

  String getErrorMessage({String? defaultErrMessage}) {
    try {
      //Case invalid form => error code will return 422
      if (statusCode == 422) {
        if (response != null &&
            response?.data != null &&
            response?.data is Map &&
            (response?.data as Map).isNotEmpty) {
          if (response?.data["errors"] != null &&
              response?.data["errors"] is Map<String, dynamic>) {
            Map<String, dynamic> errorObj =
                (response?.data["errors"] as Map<String, dynamic>);
            String errorMessage = _getErrorMessage(errorObj);
            if (errorMessage.isNotEmpty) {
              return errorMessage;
            }
          }
        }
      }

      //another error case
      if (response?.data is String) {
        return response?.data?.toString() ??
            defaultErrMessage ??
            "Something went wrong!";
      }
      String generalMessageKey = "message";
      if (response?.data[generalMessageKey] == null) {
        generalMessageKey = "messages";
      }
      if (response?.data[generalMessageKey] != null) {
        if (response?.data[generalMessageKey] is String) {
          return response!.data[generalMessageKey].toString();
        } else if (response?.data[generalMessageKey] is List &&
            (response!.data[generalMessageKey] as List).isNotEmpty) {
          return (response!.data[generalMessageKey] as List).first.toString();
        }
      }
    } catch (e) {
      LogUtil.e("get error message exception: " + e.toString());
    }

    if (errorMsg != null && errorMsg!.isNotEmpty) {
      return errorMsg!;
    }

    if (defaultErrMessage != null) {
      return defaultErrMessage;
    }
    return "Something went wrong. Please try again later!";
  }
}
