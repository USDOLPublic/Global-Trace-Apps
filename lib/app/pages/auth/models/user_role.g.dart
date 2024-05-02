// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRoleAdapter extends TypeAdapter<UserRole> {
  @override
  final int typeId = 3;

  @override
  UserRole read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserRole(
      id: fields[0] as String?,
      name: fields[1] as String?,
      permissions: (fields[2] as List?)?.cast<UserPermission>(),
      chainOfCustody: fields[6] as String?,
      createdAt: fields[4] as int?,
      type: fields[3] as String?,
      updatedAt: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserRole obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.permissions)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.chainOfCustody);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRole _$UserRoleFromJson(Map<String, dynamic> json) => UserRole(
      id: json['id'] as String?,
      name: json['name'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => UserPermission.fromJson(e as Map<String, dynamic>))
          .toList(),
      chainOfCustody: json['chainOfCustody'] as String?,
      createdAt: json['createdAt'] as int?,
      type: json['type'] as String?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$UserRoleToJson(UserRole instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'permissions': instance.permissions,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'chainOfCustody': instance.chainOfCustody,
    };
