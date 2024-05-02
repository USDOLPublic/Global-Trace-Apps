// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordProductRequest _$RecordProductRequestFromJson(
        Map<String, dynamic> json) =>
    RecordProductRequest(
      totalWeight: (json['totalWeight'] as num).toDouble(),
      weightUnit: json['weightUnit'] as String,
      recordedAt: json['recordedAt'] as int,
      uploadProofs: (json['uploadProofs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RecordProductRequestToJson(
        RecordProductRequest instance) =>
    <String, dynamic>{
      'totalWeight': instance.totalWeight,
      'weightUnit': instance.weightUnit,
      'recordedAt': instance.recordedAt,
      'uploadProofs': instance.uploadProofs,
    };
