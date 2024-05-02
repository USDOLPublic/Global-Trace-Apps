// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_definition_attribute_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDefinitionAttributeModelAdapter
    extends TypeAdapter<ProductDefinitionAttributeModel> {
  @override
  final int typeId = 68;

  @override
  ProductDefinitionAttributeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDefinitionAttributeModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      productDefinitionId: fields[3] as String?,
      attributeId: fields[4] as String?,
      order: fields[5] as int?,
      isAddManuallyOnly: fields[6] as bool?,
      isOptional: fields[7] as bool?,
      attribute: fields[8] as AttributeModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDefinitionAttributeModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.productDefinitionId)
      ..writeByte(4)
      ..write(obj.attributeId)
      ..writeByte(5)
      ..write(obj.order)
      ..writeByte(6)
      ..write(obj.isAddManuallyOnly)
      ..writeByte(7)
      ..write(obj.isOptional)
      ..writeByte(8)
      ..write(obj.attribute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDefinitionAttributeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDefinitionAttributeModel _$ProductDefinitionAttributeModelFromJson(
        Map<String, dynamic> json) =>
    ProductDefinitionAttributeModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      productDefinitionId: json['productDefinitionId'] as String?,
      attributeId: json['attributeId'] as String?,
      order: json['order'] as int?,
      isAddManuallyOnly: json['isAddManuallyOnly'] as bool?,
      isOptional: json['isOptional'] as bool?,
      attribute: json['attribute'] == null
          ? null
          : AttributeModel.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDefinitionAttributeModelToJson(
        ProductDefinitionAttributeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'productDefinitionId': instance.productDefinitionId,
      'attributeId': instance.attributeId,
      'order': instance.order,
      'isAddManuallyOnly': instance.isAddManuallyOnly,
      'isOptional': instance.isOptional,
      'attribute': instance.attribute,
    };
