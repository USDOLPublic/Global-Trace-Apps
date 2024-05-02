// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_scan_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskScanResp _$RiskScanRespFromJson(Map<String, dynamic> json) => RiskScanResp(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      entityType: json['entityType'] as String?,
      entityId: json['entityId'] as String?,
      creatorId: json['creatorId'] as String?,
    );

Map<String, dynamic> _$RiskScanRespToJson(RiskScanResp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'creatorId': instance.creatorId,
    };
