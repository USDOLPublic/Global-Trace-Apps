// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_record_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryRecordProductAdapter extends TypeAdapter<HistoryRecordProduct> {
  @override
  final int typeId = 46;

  @override
  HistoryRecordProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryRecordProduct(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      totalWeight: fields[3] as double?,
      weightUnit: fields[4] as String?,
      facilityId: fields[5] as String?,
      recordedAt: fields[6] as int?,
      uploadProofs: (fields[7] as List?)?.cast<FileAttachmentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HistoryRecordProduct obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.totalWeight)
      ..writeByte(4)
      ..write(obj.weightUnit)
      ..writeByte(5)
      ..write(obj.facilityId)
      ..writeByte(6)
      ..write(obj.recordedAt)
      ..writeByte(7)
      ..write(obj.uploadProofs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryRecordProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryRecordProduct _$HistoryRecordProductFromJson(
        Map<String, dynamic> json) =>
    HistoryRecordProduct(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      weightUnit: json['weightUnit'] as String?,
      facilityId: json['facilityId'] as String?,
      recordedAt: json['recordedAt'] as int?,
      uploadProofs: (json['uploadProofs'] as List<dynamic>?)
          ?.map((e) => FileAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryRecordProductToJson(
        HistoryRecordProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'totalWeight': instance.totalWeight,
      'weightUnit': instance.weightUnit,
      'facilityId': instance.facilityId,
      'recordedAt': instance.recordedAt,
      'uploadProofs': instance.uploadProofs,
    };
