// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      accessToken: json['accessToken'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      expireAt: json['expireAt'] as int? ?? 0,
      refreshToken: json['refreshToken'] as String? ?? "",
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expireAt': instance.expireAt,
      'userId': instance.userId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
