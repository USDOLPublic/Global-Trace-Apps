// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriorityModelAdapter extends TypeAdapter<PriorityModel> {
  @override
  final int typeId = 28;

  @override
  PriorityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriorityModel(
      id: fields[0] as String,
      displayName: fields[1] as String?,
      value: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PriorityModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
