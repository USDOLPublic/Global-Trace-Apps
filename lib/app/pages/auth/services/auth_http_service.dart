import 'dart:convert';

import 'package:usdol/app/core.dart';
import 'package:dio/dio.dart' as dio;

class AuthHttpService extends BaseApiClient {
  Future<BaseResp<LoginResp>> login(
      {required String userName, required String password}) async {
    return request<LoginResp>(
      Method.post,
      AppApi.login,
      data: {
        "email": userName,
        "password": password,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return LoginResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> logout() async {
    return request<dynamic>(
      Method.delete,
      AppApi.logout,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<LoginResp>> refreshToken(String refreshToken) async {
    dio.Dio refreshTokenDio = dio.Dio();
    try {
      refreshTokenDio.options = service.options;
      var response = await refreshTokenDio.post<Map<String, dynamic>>(
        AppApi.refreshToken,
        data: {
          "refreshToken": refreshToken,
        },
      );
      if (response.data != null) {
        LoginResp resp = LoginResp.fromJson(response.data!);
        return BaseResp<LoginResp>(
            data: resp, statusCode: response.statusCode!, response: response);
      } else {
        return BaseResp.withError(
            statusCode: response.statusCode ?? -1,
            errorMsg: response.statusMessage ?? "Unknown error!");
      }
    } on dio.DioException catch (dioErr) {
      String errMessage = jsonEncode(dioErr.response?.data ?? "");
      if (errMessage.isEmpty) {
        errMessage = dioErr.message ?? "Unknown!";
      }
      LogUtil.d(
          "Refresh token: -> Error Status: ${dioErr.response?.statusCode} Mess: $errMessage");

      return BaseResp<LoginResp>.withError(
        statusCode: dioErr.response?.statusCode ??
            (dioErr.type == dio.DioExceptionType.connectionTimeout ||
                    dioErr.type == dio.DioExceptionType.connectionError
                ? 408
                : -1),
        errorMsg: errMessage,
      );
    } catch (e) {
      LogUtil.d("Refresh token: -> Error Status: ${e.toString()}");
      return BaseResp<LoginResp>.withError(errorMsg: "errorMsg");
    }
  }

  Future<BaseResp<dynamic>> resetPassword(String email) async {
    return request<dynamic>(
      Method.post,
      AppApi.resetPassword,
      data: {
        "email": email,
      },
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<dynamic>> updatePassword(
      String token, String password) async {
    return request<dynamic>(
      Method.put,
      AppApi.resetPassword,
      data: {
        "token": token,
        "password": password,
      },
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<dynamic>> resetPasswordCheckToken(String token) async {
    return request<dynamic>(
      Method.post,
      AppApi.resetPasswordCheckToken,
      data: {
        "token": token,
      },
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<RegisterResp>> signUp(
      {required String inviteToken, required String password}) async {
    return request<RegisterResp>(
      Method.post,
      AppApi.signup,
      data: {
        "token": inviteToken,
        "password": password,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return RegisterResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }
}
