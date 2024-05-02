// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignee_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssigneeModelAdapter extends TypeAdapter<AssigneeModel> {
  @override
  final int typeId = 24;

  @override
  AssigneeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssigneeModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      email: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      firstName: fields[5] as String?,
      lastName: fields[6] as String?,
      status: fields[7] as int?,
      lastLoginAt: fields[8] as int?,
      deletedAt: fields[9] as int?,
      joinedAt: fields[10] as int?,
      updatedProfileAt: fields[11] as int?,
      answeredSaqAt: fields[12] as int?,
      latestActivityAt: fields[13] as int?,
      addedPartnerAt: fields[14] as int?,
      finishedGuidanceAt: fields[15] as int?,
      roleId: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AssigneeModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.firstName)
      ..writeByte(6)
      ..write(obj.lastName)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.lastLoginAt)
      ..writeByte(9)
      ..write(obj.deletedAt)
      ..writeByte(10)
      ..write(obj.joinedAt)
      ..writeByte(11)
      ..write(obj.updatedProfileAt)
      ..writeByte(12)
      ..write(obj.answeredSaqAt)
      ..writeByte(13)
      ..write(obj.latestActivityAt)
      ..writeByte(14)
      ..write(obj.addedPartnerAt)
      ..writeByte(15)
      ..write(obj.finishedGuidanceAt)
      ..writeByte(16)
      ..write(obj.roleId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssigneeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssigneeModel _$AssigneeModelFromJson(Map<String, dynamic> json) =>
    AssigneeModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      status: json['status'] as int?,
      lastLoginAt: json['lastLoginAt'] as int?,
      deletedAt: json['deletedAt'] as int?,
      joinedAt: json['joinedAt'] as int?,
      updatedProfileAt: json['updatedProfileAt'] as int?,
      answeredSaqAt: json['answeredSaqAt'] as int?,
      latestActivityAt: json['latestActivityAt'] as int?,
      addedPartnerAt: json['addedPartnerAt'] as int?,
      finishedGuidanceAt: json['finishedGuidanceAt'] as int?,
      roleId: json['roleId'] as String?,
    );

Map<String, dynamic> _$AssigneeModelToJson(AssigneeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'status': instance.status,
      'lastLoginAt': instance.lastLoginAt,
      'deletedAt': instance.deletedAt,
      'joinedAt': instance.joinedAt,
      'updatedProfileAt': instance.updatedProfileAt,
      'answeredSaqAt': instance.answeredSaqAt,
      'latestActivityAt': instance.latestActivityAt,
      'addedPartnerAt': instance.addedPartnerAt,
      'finishedGuidanceAt': instance.finishedGuidanceAt,
      'roleId': instance.roleId,
    };
