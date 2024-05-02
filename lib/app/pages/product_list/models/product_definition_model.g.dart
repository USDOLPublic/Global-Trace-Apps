// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_definition_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDefinitionModelAdapter
    extends TypeAdapter<ProductDefinitionModel> {
  @override
  final int typeId = 67;

  @override
  ProductDefinitionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDefinitionModel(
      id: fields[0] as String?,
      name: fields[3] as String?,
      nameTranslation: (fields[4] as Map?)?.cast<String, String>(),
      productDefinitionAttributes:
          (fields[5] as List?)?.cast<ProductDefinitionAttributeModel>(),
      updatedAt: fields[2] as int?,
      createdAt: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDefinitionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.nameTranslation)
      ..writeByte(5)
      ..write(obj.productDefinitionAttributes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDefinitionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDefinitionModel _$ProductDefinitionModelFromJson(
        Map<String, dynamic> json) =>
    ProductDefinitionModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      nameTranslation: (json['nameTranslation'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      productDefinitionAttributes:
          (json['productDefinitionAttributes'] as List<dynamic>?)
              ?.map((e) => ProductDefinitionAttributeModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      updatedAt: json['updatedAt'] as int?,
      createdAt: json['createdAt'] as int?,
    );

Map<String, dynamic> _$ProductDefinitionModelToJson(
        ProductDefinitionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'nameTranslation': instance.nameTranslation,
      'productDefinitionAttributes': instance.productDefinitionAttributes,
    };
