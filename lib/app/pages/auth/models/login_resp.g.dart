// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResp _$LoginRespFromJson(Map<String, dynamic> json) => LoginResp(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      expireAt: json['expireAt'] as int?,
    );

Map<String, dynamic> _$LoginRespToJson(LoginResp instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expireAt': instance.expireAt,
    };
