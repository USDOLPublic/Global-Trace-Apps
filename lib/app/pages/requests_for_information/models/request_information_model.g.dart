// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_information_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestInformationModelAdapter
    extends TypeAdapter<RequestInformationModel> {
  @override
  final int typeId = 23;

  @override
  RequestInformationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequestInformationModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      recordedAt: fields[13] as int?,
      updatedAt: fields[2] as int?,
      facilityId: fields[3] as String?,
      location: fields[4] as String?,
      message: fields[5] as String?,
      laborRisks: (fields[6] as List?)?.cast<LaborRisksResp>(),
      assigneeId: fields[7] as String?,
      reason: fields[8] as String?,
      status: fields[20] as int?,
      latestActivityAt: fields[19] as int?,
      assignee: fields[9] as AssigneeModel?,
      facility: fields[10] as FacilityModel?,
      responses: (fields[12] as List?)?.cast<RespondModel>(),
      creator: fields[11] as AssigneeModel?,
      uploadFiles: (fields[18] as List?)?.cast<String>(),
      auditReportNumber: fields[17] as dynamic,
      creatorId: fields[14] as String?,
      isNoFollowUp: fields[16] as bool?,
      priority: fields[15] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RequestInformationModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.facilityId)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.message)
      ..writeByte(6)
      ..write(obj.laborRisks)
      ..writeByte(7)
      ..write(obj.assigneeId)
      ..writeByte(8)
      ..write(obj.reason)
      ..writeByte(9)
      ..write(obj.assignee)
      ..writeByte(10)
      ..write(obj.facility)
      ..writeByte(11)
      ..write(obj.creator)
      ..writeByte(12)
      ..write(obj.responses)
      ..writeByte(13)
      ..write(obj.recordedAt)
      ..writeByte(14)
      ..write(obj.creatorId)
      ..writeByte(15)
      ..write(obj.priority)
      ..writeByte(16)
      ..write(obj.isNoFollowUp)
      ..writeByte(17)
      ..write(obj.auditReportNumber)
      ..writeByte(18)
      ..write(obj.uploadFiles)
      ..writeByte(19)
      ..write(obj.latestActivityAt)
      ..writeByte(20)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestInformationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestInformationModel _$RequestInformationModelFromJson(
        Map<String, dynamic> json) =>
    RequestInformationModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      recordedAt: json['recordedAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      facilityId: json['facilityId'] as String?,
      location: json['location'] as String?,
      message: json['message'] as String?,
      laborRisks: (json['laborRisks'] as List<dynamic>?)
          ?.map((e) => LaborRisksResp.fromJson(e as Map<String, dynamic>))
          .toList(),
      assigneeId: json['assigneeId'] as String?,
      reason: json['reason'] as String?,
      status: json['status'] as int?,
      latestActivityAt: json['latestActivityAt'] as int?,
      assignee: json['assignee'] == null
          ? null
          : AssigneeModel.fromJson(json['assignee'] as Map<String, dynamic>),
      facility: json['facility'] == null
          ? null
          : FacilityModel.fromJson(json['facility'] as Map<String, dynamic>),
      responses: (json['responses'] as List<dynamic>?)
          ?.map((e) => RespondModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      creator: json['creator'] == null
          ? null
          : AssigneeModel.fromJson(json['creator'] as Map<String, dynamic>),
      uploadFiles: (json['uploadFiles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      auditReportNumber: json['auditReportNumber'],
      creatorId: json['creatorId'] as String?,
      isNoFollowUp: json['isNoFollowUp'] as bool?,
      priority: json['priority'] as int?,
    );

Map<String, dynamic> _$RequestInformationModelToJson(
        RequestInformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'facilityId': instance.facilityId,
      'location': instance.location,
      'message': instance.message,
      'laborRisks': instance.laborRisks,
      'assigneeId': instance.assigneeId,
      'reason': instance.reason,
      'assignee': instance.assignee,
      'facility': instance.facility,
      'creator': instance.creator,
      'responses': instance.responses,
      'recordedAt': instance.recordedAt,
      'creatorId': instance.creatorId,
      'priority': instance.priority,
      'isNoFollowUp': instance.isNoFollowUp,
      'auditReportNumber': instance.auditReportNumber,
      'uploadFiles': instance.uploadFiles,
      'latestActivityAt': instance.latestActivityAt,
      'status': instance.status,
    };
