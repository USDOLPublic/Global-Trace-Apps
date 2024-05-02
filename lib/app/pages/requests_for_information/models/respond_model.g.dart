// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respond_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RespondModelAdapter extends TypeAdapter<RespondModel> {
  @override
  final int typeId = 25;

  @override
  RespondModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RespondModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      grievanceReportId: fields[3] as String?,
      laborRisks: (fields[5] as List?)?.cast<LaborRisksResp>(),
      message: fields[4] as String?,
      priority: fields[6] as int?,
      recordedAt: fields[7] as int?,
      uploadImages: (fields[8] as List?)?.cast<String>(),
      uploadedImages: (fields[10] as List?)?.cast<String>(),
      auditReportNumber: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RespondModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.grievanceReportId)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.laborRisks)
      ..writeByte(6)
      ..write(obj.priority)
      ..writeByte(7)
      ..write(obj.recordedAt)
      ..writeByte(8)
      ..write(obj.uploadImages)
      ..writeByte(9)
      ..write(obj.auditReportNumber)
      ..writeByte(10)
      ..write(obj.uploadedImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespondModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespondModel _$RespondModelFromJson(Map<String, dynamic> json) => RespondModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      grievanceReportId: json['grievanceReportId'] as String?,
      laborRisks: (json['laborRisks'] as List<dynamic>?)
          ?.map((e) => LaborRisksResp.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      priority: json['priority'] as int?,
      recordedAt: json['recordedAt'] as int?,
      uploadImages: (json['uploadImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      uploadedImages: (json['uploadedImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      auditReportNumber: json['auditReportNumber'] as String?,
    );

Map<String, dynamic> _$RespondModelToJson(RespondModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'grievanceReportId': instance.grievanceReportId,
      'message': instance.message,
      'laborRisks': instance.laborRisks,
      'priority': instance.priority,
      'recordedAt': instance.recordedAt,
      'uploadImages': instance.uploadImages,
      'auditReportNumber': instance.auditReportNumber,
      'uploadedImages': instance.uploadedImages,
    };
