// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indicator_risk_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndicatorRiskDataAdapter extends TypeAdapter<IndicatorRiskData> {
  @override
  final int typeId = 31;

  @override
  IndicatorRiskData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndicatorRiskData(
      risk: fields[0] as Risk?,
      indicator: fields[1] as IndicatorModel?,
      subIndicatorRiskData: (fields[2] as List?)?.cast<SubIndicatorRiskData>(),
    );
  }

  @override
  void write(BinaryWriter writer, IndicatorRiskData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.risk)
      ..writeByte(1)
      ..write(obj.indicator)
      ..writeByte(2)
      ..write(obj.subIndicatorRiskData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorRiskDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndicatorRiskData _$IndicatorRiskDataFromJson(Map<String, dynamic> json) =>
    IndicatorRiskData(
      risk: json['risk'] == null
          ? null
          : Risk.fromJson(json['risk'] as Map<String, dynamic>),
      indicator: json['indicator'] == null
          ? null
          : IndicatorModel.fromJson(json['indicator'] as Map<String, dynamic>),
      subIndicatorRiskData: (json['subIndicatorRiskData'] as List<dynamic>?)
          ?.map((e) => SubIndicatorRiskData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IndicatorRiskDataToJson(IndicatorRiskData instance) =>
    <String, dynamic>{
      'risk': instance.risk,
      'indicator': instance.indicator,
      'subIndicatorRiskData': instance.subIndicatorRiskData,
    };
