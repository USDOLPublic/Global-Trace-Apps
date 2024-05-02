// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_permission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPermissionAdapter extends TypeAdapter<UserPermission> {
  @override
  final int typeId = 2;

  @override
  UserPermission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPermission(
      id: fields[0] as String?,
      name: fields[1] as String?,
      action: fields[2] as String?,
      groupType: fields[6] as String?,
      groups: fields[5] as String?,
      label: fields[4] as String?,
      sortOrder: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserPermission obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.action)
      ..writeByte(3)
      ..write(obj.sortOrder)
      ..writeByte(4)
      ..write(obj.label)
      ..writeByte(5)
      ..write(obj.groups)
      ..writeByte(6)
      ..write(obj.groupType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPermissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPermission _$UserPermissionFromJson(Map<String, dynamic> json) =>
    UserPermission(
      id: json['id'] as String?,
      name: json['name'] as String?,
      action: json['action'] as String?,
      groupType: json['groupType'] as String?,
      groups: json['groups'] as String?,
      label: json['label'] as String?,
      sortOrder: json['sortOrder'] as int?,
    );

Map<String, dynamic> _$UserPermissionToJson(UserPermission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'action': instance.action,
      'sortOrder': instance.sortOrder,
      'label': instance.label,
      'groups': instance.groups,
      'groupType': instance.groupType,
    };
