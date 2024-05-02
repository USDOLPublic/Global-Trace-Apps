// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProvinceModelAdapter extends TypeAdapter<ProvinceModel> {
  @override
  final int typeId = 51;

  @override
  ProvinceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProvinceModel(
      id: fields[0] as String?,
      countryId: fields[1] as String?,
      provinceCode: fields[2] as dynamic,
      province: fields[3] as String?,
      translation: (fields[4] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProvinceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.countryId)
      ..writeByte(2)
      ..write(obj.provinceCode)
      ..writeByte(3)
      ..write(obj.province)
      ..writeByte(4)
      ..write(obj.translation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceModel _$ProvinceModelFromJson(Map<String, dynamic> json) =>
    ProvinceModel(
      id: json['id'] as String?,
      countryId: json['countryId'] as String?,
      provinceCode: json['provinceCode'],
      province: json['province'] as String?,
      translation: json['translation'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProvinceModelToJson(ProvinceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryId': instance.countryId,
      'provinceCode': instance.provinceCode,
      'province': instance.province,
      'translation': instance.translation,
    };
