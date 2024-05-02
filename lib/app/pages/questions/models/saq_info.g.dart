// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saq_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SAQInfo _$SAQInfoFromJson(Map<String, dynamic> json) => SAQInfo(
      forFacilityId: json['forFacilityId'] as String,
      id: json['id'] as String,
      completedSaqAt: json['completedSaqAt'] as int?,
      isDraft: json['isDraft'] as bool?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$SAQInfoToJson(SAQInfo instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'forFacilityId': instance.forFacilityId,
      'completedSaqAt': instance.completedSaqAt,
      'isDraft': instance.isDraft,
    };
