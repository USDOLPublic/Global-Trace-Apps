// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transformation_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransformationItemAdapter extends TypeAdapter<TransformationItem> {
  @override
  final int typeId = 45;

  @override
  TransformationItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransformationItem(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      transformationId: fields[3] as String?,
      entityId: fields[4] as String?,
      isInput: fields[5] as bool?,
      product: fields[6] as ProductModel?,
    );
  }

  @override
  void write(BinaryWriter writer, TransformationItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.transformationId)
      ..writeByte(4)
      ..write(obj.entityId)
      ..writeByte(5)
      ..write(obj.isInput)
      ..writeByte(6)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransformationItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransformationItem _$TransformationItemFromJson(Map<String, dynamic> json) =>
    TransformationItem(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      transformationId: json['transformationId'] as String?,
      entityId: json['entityId'] as String?,
      isInput: json['isInput'] as bool?,
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransformationItemToJson(TransformationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'transformationId': instance.transformationId,
      'entityId': instance.entityId,
      'isInput': instance.isInput,
      'product': instance.product,
    };
