// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      email: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      firstName: fields[5] as String?,
      lastName: fields[6] as String?,
      lastLoginAt: fields[7] as int?,
      deletedAt: fields[8] as int?,
      permissions: (fields[9] as List?)?.cast<UserPermission>(),
      role: fields[10] as UserRole?,
      roleId: fields[11] as String?,
      status: fields[12] as int?,
      joinedAt: fields[13] as int?,
      updatedProfileAt: fields[14] as int?,
      answeredSaqAt: fields[15] as int?,
      addedPartnerAt: fields[16] as int?,
      finishedGuidanceAt: fields[17] as int?,
      currentFacility: fields[18] as FacilityModel?,
      completedConfiguringSystemAt: fields[19] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(20)
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
      ..write(obj.lastLoginAt)
      ..writeByte(8)
      ..write(obj.deletedAt)
      ..writeByte(9)
      ..write(obj.permissions)
      ..writeByte(10)
      ..write(obj.role)
      ..writeByte(11)
      ..write(obj.roleId)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.joinedAt)
      ..writeByte(14)
      ..write(obj.updatedProfileAt)
      ..writeByte(15)
      ..write(obj.answeredSaqAt)
      ..writeByte(16)
      ..write(obj.addedPartnerAt)
      ..writeByte(17)
      ..write(obj.finishedGuidanceAt)
      ..writeByte(18)
      ..write(obj.currentFacility)
      ..writeByte(19)
      ..write(obj.completedConfiguringSystemAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      lastLoginAt: json['lastLoginAt'] as int?,
      deletedAt: json['deletedAt'] as int?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => UserPermission.fromJson(e as Map<String, dynamic>))
          .toList(),
      role: json['role'] == null
          ? null
          : UserRole.fromJson(json['role'] as Map<String, dynamic>),
      roleId: json['roleId'] as String?,
      status: json['status'] as int?,
      joinedAt: json['joinedAt'] as int?,
      updatedProfileAt: json['updatedProfileAt'] as int?,
      answeredSaqAt: json['answeredSaqAt'] as int?,
      addedPartnerAt: json['addedPartnerAt'] as int?,
      finishedGuidanceAt: json['finishedGuidanceAt'] as int?,
      currentFacility: json['currentFacility'] == null
          ? null
          : FacilityModel.fromJson(
              json['currentFacility'] as Map<String, dynamic>),
      completedConfiguringSystemAt:
          json['completedConfiguringSystemAt'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'lastLoginAt': instance.lastLoginAt,
      'deletedAt': instance.deletedAt,
      'permissions': instance.permissions,
      'role': instance.role,
      'roleId': instance.roleId,
      'status': instance.status,
      'joinedAt': instance.joinedAt,
      'updatedProfileAt': instance.updatedProfileAt,
      'answeredSaqAt': instance.answeredSaqAt,
      'addedPartnerAt': instance.addedPartnerAt,
      'finishedGuidanceAt': instance.finishedGuidanceAt,
      'currentFacility': instance.currentFacility,
      'completedConfiguringSystemAt': instance.completedConfiguringSystemAt,
    };
