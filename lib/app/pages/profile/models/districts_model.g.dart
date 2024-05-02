// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'districts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DistrictModelAdapter extends TypeAdapter<DistrictModel> {
  @override
  final int typeId = 52;

  @override
  DistrictModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DistrictModel(
      id: fields[0] as String?,
      provinceId: fields[1] as String?,
      districtCode: fields[2] as int?,
      district: fields[3] as String?,
      translation: (fields[4] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, DistrictModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.provinceId)
      ..writeByte(2)
      ..write(obj.districtCode)
      ..writeByte(3)
      ..write(obj.district)
      ..writeByte(4)
      ..write(obj.translation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistrictModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) =>
    DistrictModel(
      id: json['id'] as String?,
      provinceId: json['provinceId'] as String?,
      districtCode: json['districtCode'] as int?,
      district: json['district'] as String?,
      translation: json['translation'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provinceId': instance.provinceId,
      'districtCode': instance.districtCode,
      'district': instance.district,
      'translation': instance.translation,
    };
