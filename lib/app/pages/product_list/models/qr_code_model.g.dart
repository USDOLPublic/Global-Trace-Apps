// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QrCodeModelAdapter extends TypeAdapter<QrCodeModel> {
  @override
  final int typeId = 69;

  @override
  QrCodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QrCodeModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      qrCodeBatchId: fields[3] as String?,
      lotId: fields[4] as String?,
      code: fields[5] as String?,
      status: fields[6] as int?,
      deletedAt: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, QrCodeModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.qrCodeBatchId)
      ..writeByte(4)
      ..write(obj.lotId)
      ..writeByte(5)
      ..write(obj.code)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrCodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeModel _$QrCodeModelFromJson(Map<String, dynamic> json) => QrCodeModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      qrCodeBatchId: json['qrCodeBatchId'] as String?,
      lotId: json['lotId'] as String?,
      code: json['code'] as String?,
      status: json['status'] as int?,
      deletedAt: json['deletedAt'] as int?,
    );

Map<String, dynamic> _$QrCodeModelToJson(QrCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'qrCodeBatchId': instance.qrCodeBatchId,
      'lotId': instance.lotId,
      'code': instance.code,
      'status': instance.status,
      'deletedAt': instance.deletedAt,
    };
