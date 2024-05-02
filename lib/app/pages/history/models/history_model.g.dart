// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryModelAdapter extends TypeAdapter<HistoryModel> {
  @override
  final int typeId = 40;

  @override
  HistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      facilityId: fields[3] as String?,
      type: fields[4] as int?,
      recordedAt: fields[5] as int?,
      deletedAt: fields[7] as int?,
      recordProduct: fields[6] as HistoryRecordProduct?,
      transformation: fields[8] as HistoryTransformation?,
      transaction: fields[9] as HistoryTransaction?,
      status: fields[10] as String?,
      tradeType: fields[11] as String?,
      note: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.facilityId)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.recordedAt)
      ..writeByte(7)
      ..write(obj.deletedAt)
      ..writeByte(6)
      ..write(obj.recordProduct)
      ..writeByte(8)
      ..write(obj.transformation)
      ..writeByte(9)
      ..write(obj.transaction)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.tradeType)
      ..writeByte(12)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      facilityId: json['facilityId'] as String?,
      type: json['type'] as int?,
      recordedAt: json['recordedAt'] as int?,
      deletedAt: json['deletedAt'] as int?,
      recordProduct: json['recordProduct'] == null
          ? null
          : HistoryRecordProduct.fromJson(
              json['recordProduct'] as Map<String, dynamic>),
      transformation: json['transformation'] == null
          ? null
          : HistoryTransformation.fromJson(
              json['transformation'] as Map<String, dynamic>),
      transaction: json['transaction'] == null
          ? null
          : HistoryTransaction.fromJson(
              json['transaction'] as Map<String, dynamic>),
      status: json['status'] as String? ?? HistoryStatus.complete,
      tradeType: json['tradeType'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'facilityId': instance.facilityId,
      'type': instance.type,
      'recordedAt': instance.recordedAt,
      'deletedAt': instance.deletedAt,
      'recordProduct': instance.recordProduct,
      'transformation': instance.transformation,
      'transaction': instance.transaction,
      'status': instance.status,
      'tradeType': instance.tradeType,
      'note': instance.note,
    };
