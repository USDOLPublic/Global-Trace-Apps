// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_scan_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskScanRequest _$RiskScanRequestFromJson(Map<String, dynamic> json) =>
    RiskScanRequest(
      id: json['id'] as String?,
      facilityId: json['facilityId'] as String,
      location: json['location'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      priority: json['priority'] as int,
      laborRisks: (json['laborRisks'] as List<dynamic>)
          .map((e) => LaborRisksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
      auditReportNumber: json['auditReportNumber'] as String?,
      uploadFiles: (json['uploadFiles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RiskScanRequestToJson(RiskScanRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'facilityId': instance.facilityId,
      'location': instance.location,
      'recordedAt': instance.recordedAt.toIso8601String(),
      'priority': instance.priority,
      'laborRisks': instance.laborRisks,
      'message': instance.message,
      'auditReportNumber': instance.auditReportNumber,
      'uploadFiles': instance.uploadFiles,
    };
