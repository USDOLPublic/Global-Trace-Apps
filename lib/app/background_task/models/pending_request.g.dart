// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendingRequestModelAdapter extends TypeAdapter<PendingRequestModel> {
  @override
  final int typeId = 20;

  @override
  PendingRequestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingRequestModel(
      id: fields[0] as String,
      createAt: fields[1] as DateTime,
      type: fields[2] as String,
      status: fields[3] as String,
      requestData: fields[4] as String,
      errorCause: fields[5] as String,
      userId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PendingRequestModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createAt)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.requestData)
      ..writeByte(5)
      ..write(obj.errorCause)
      ..writeByte(6)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingRequestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
