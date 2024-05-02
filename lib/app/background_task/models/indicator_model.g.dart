// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indicator_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndicatorModelAdapter extends TypeAdapter<IndicatorModel> {
  @override
  final int typeId = 21;

  @override
  IndicatorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndicatorModel(
      id: fields[0] as String?,
      name: fields[4] as String?,
      createdAt: fields[1] as int?,
      deletedAt: fields[7] as int?,
      type: fields[5] as int?,
      updatedAt: fields[2] as int?,
      parentId: fields[3] as String?,
      categoryId: fields[9] as String?,
      riskSeverity: fields[6] as int?,
      translation: (fields[8] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, IndicatorModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.parentId)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.riskSeverity)
      ..writeByte(7)
      ..write(obj.deletedAt)
      ..writeByte(8)
      ..write(obj.translation)
      ..writeByte(9)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndicatorModel _$IndicatorModelFromJson(Map<String, dynamic> json) =>
    IndicatorModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] as int?,
      deletedAt: json['deletedAt'] as int?,
      type: json['type'] as int?,
      updatedAt: json['updatedAt'] as int?,
      parentId: json['parentId'] as String?,
      categoryId: json['categoryId'] as String?,
      riskSeverity: json['riskSeverity'] as int?,
      translation: json['translation'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$IndicatorModelToJson(IndicatorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'parentId': instance.parentId,
      'name': instance.name,
      'type': instance.type,
      'riskSeverity': instance.riskSeverity,
      'deletedAt': instance.deletedAt,
      'translation': instance.translation,
      'categoryId': instance.categoryId,
    };
