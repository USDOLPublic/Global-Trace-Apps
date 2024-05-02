// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'severity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeverityModelAdapter extends TypeAdapter<SeverityModel> {
  @override
  final int typeId = 22;

  @override
  SeverityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeverityModel(
      id: fields[0] as String,
      name: fields[1] as String?,
      index: fields[2] as int,
      color: fields[3] as int?,
      value: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SeverityModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.index)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeverityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeverityModel _$SeverityModelFromJson(Map<String, dynamic> json) =>
    SeverityModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      index: json['index'] as int,
      color: json['color'] as int?,
      value: json['value'] as int?,
    );

Map<String, dynamic> _$SeverityModelToJson(SeverityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'index': instance.index,
      'color': instance.color,
      'value': instance.value,
    };
