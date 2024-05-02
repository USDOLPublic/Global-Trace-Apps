// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResp _$RegisterRespFromJson(Map<String, dynamic> json) => RegisterResp(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      lastLoginAt: json['lastLoginAt'] as int?,
      deletedAt: json['deletedAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$RegisterRespToJson(RegisterResp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'lastLoginAt': instance.lastLoginAt,
      'deletedAt': instance.deletedAt,
      'updatedAt': instance.updatedAt,
    };
