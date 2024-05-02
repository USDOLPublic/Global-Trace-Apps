// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryModelAdapter extends TypeAdapter<CountryModel> {
  @override
  final int typeId = 50;

  @override
  CountryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryModel(
      id: fields[0] as String?,
      countryCode: fields[1] as String?,
      country: fields[2] as String?,
      translation: (fields[3] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CountryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.countryCode)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.translation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      country: json['country'] as String?,
      translation: json['translation'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'country': instance.country,
      'translation': instance.translation,
    };
