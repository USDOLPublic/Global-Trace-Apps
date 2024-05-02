// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RiskDataAdapter extends TypeAdapter<RiskData> {
  @override
  final int typeId = 32;

  @override
  RiskData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RiskData(
      risk: fields[0] as Risk?,
      category: fields[1] as IndicatorModel?,
      sourceRiskData: (fields[2] as List?)?.cast<SourceRiskData>(),
      indicatorRiskData: (fields[3] as List?)?.cast<IndicatorRiskData>(),
    );
  }

  @override
  void write(BinaryWriter writer, RiskData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.risk)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.sourceRiskData)
      ..writeByte(3)
      ..write(obj.indicatorRiskData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RiskDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskData _$RiskDataFromJson(Map<String, dynamic> json) => RiskData(
      risk: json['risk'] == null
          ? null
          : Risk.fromJson(json['risk'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : IndicatorModel.fromJson(json['category'] as Map<String, dynamic>),
      sourceRiskData: (json['sourceRiskData'] as List<dynamic>?)
          ?.map((e) => SourceRiskData.fromJson(e as Map<String, dynamic>))
          .toList(),
      indicatorRiskData: (json['indicatorRiskData'] as List<dynamic>?)
          ?.map((e) => IndicatorRiskData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RiskDataToJson(RiskData instance) => <String, dynamic>{
      'risk': instance.risk,
      'category': instance.category,
      'sourceRiskData': instance.sourceRiskData,
      'indicatorRiskData': instance.indicatorRiskData,
    };
