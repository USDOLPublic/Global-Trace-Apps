// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_attribute_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdditionalAttributeModelAdapter
    extends TypeAdapter<AdditionalAttributeModel> {
  @override
  final int typeId = 61;

  @override
  AdditionalAttributeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdditionalAttributeModel(
      value: fields[0] as dynamic,
      attributeId: fields[1] as String?,
      quantityUnit: fields[2] as String?,
      attribute: fields[3] as AttributeModel?,
    );
  }

  @override
  void write(BinaryWriter writer, AdditionalAttributeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.attributeId)
      ..writeByte(2)
      ..write(obj.quantityUnit)
      ..writeByte(3)
      ..write(obj.attribute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditionalAttributeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalAttributeModel _$AdditionalAttributeModelFromJson(
        Map<String, dynamic> json) =>
    AdditionalAttributeModel(
      value: json['value'],
      attributeId: json['attributeId'] as String?,
      quantityUnit: json['quantityUnit'] as String?,
      attribute: json['attribute'] == null
          ? null
          : AttributeModel.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdditionalAttributeModelToJson(
        AdditionalAttributeModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'attributeId': instance.attributeId,
      'quantityUnit': instance.quantityUnit,
      'attribute': instance.attribute,
    };
