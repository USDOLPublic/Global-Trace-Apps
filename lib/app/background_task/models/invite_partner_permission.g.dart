// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_partner_permission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvitePartnerPermissionAdapter
    extends TypeAdapter<InvitePartnerPermission> {
  @override
  final int typeId = 27;

  @override
  InvitePartnerPermission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvitePartnerPermission(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      name: fields[3] as String?,
      type: fields[4] as String?,
      chainOfCustody: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InvitePartnerPermission obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.chainOfCustody);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvitePartnerPermissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitePartnerPermission _$InvitePartnerPermissionFromJson(
        Map<String, dynamic> json) =>
    InvitePartnerPermission(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      chainOfCustody: json['chainOfCustody'] as String?,
    );

Map<String, dynamic> _$InvitePartnerPermissionToJson(
        InvitePartnerPermission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'type': instance.type,
      'chainOfCustody': instance.chainOfCustody,
    };
