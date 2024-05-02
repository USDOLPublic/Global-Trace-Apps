// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttributeModelAdapter extends TypeAdapter<AttributeModel> {
  @override
  final int typeId = 62;

  @override
  AttributeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttributeModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      name: fields[3] as String?,
      type: fields[4] as String?,
      category: fields[5] as String?,
      nameTranslation: (fields[6] as Map?)?.cast<String, String>(),
      options: (fields[7] as List?)?.cast<AttributeOptionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AttributeModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.nameTranslation)
      ..writeByte(7)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeModel _$AttributeModelFromJson(Map<String, dynamic> json) =>
    AttributeModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      nameTranslation: (json['nameTranslation'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => AttributeOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributeModelToJson(AttributeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'type': instance.type,
      'category': instance.category,
      'nameTranslation': instance.nameTranslation,
      'options': instance.options,
    };
