// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttributeRequestAdapter extends TypeAdapter<AttributeRequest> {
  @override
  final int typeId = 66;

  @override
  AttributeRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttributeRequest(
      category: fields[0] as String?,
      isOptional: fields[1] as bool?,
      type: fields[2] as String?,
      id: fields[3] as String?,
      value: fields[4] as dynamic,
      quantityUnit: fields[5] as String?,
      name: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AttributeRequest obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.isOptional)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.value)
      ..writeByte(5)
      ..write(obj.quantityUnit)
      ..writeByte(6)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeRequest _$AttributeRequestFromJson(Map<String, dynamic> json) =>
    AttributeRequest(
      category: json['category'] as String?,
      isOptional: json['isOptional'] as bool?,
      type: json['type'] as String?,
      id: json['id'] as String?,
      value: json['value'],
      quantityUnit: json['quantityUnit'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AttributeRequestToJson(AttributeRequest instance) =>
    <String, dynamic>{
      'category': instance.category,
      'isOptional': instance.isOptional,
      'type': instance.type,
      'id': instance.id,
      'value': instance.value,
      'quantityUnit': instance.quantityUnit,
      'name': instance.name,
    };
