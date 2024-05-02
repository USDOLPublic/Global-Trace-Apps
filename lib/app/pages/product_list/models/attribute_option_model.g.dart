// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_option_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttributeOptionModelAdapter extends TypeAdapter<AttributeOptionModel> {
  @override
  final int typeId = 63;

  @override
  AttributeOptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttributeOptionModel(
      value: fields[0] as String?,
      translation: (fields[1] as Map?)?.cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AttributeOptionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.translation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeOptionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeOptionModel _$AttributeOptionModelFromJson(
        Map<String, dynamic> json) =>
    AttributeOptionModel(
      value: json['value'] as String?,
      translation: (json['translation'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$AttributeOptionModelToJson(
        AttributeOptionModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'translation': instance.translation,
    };
