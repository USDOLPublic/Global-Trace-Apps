// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_indicator_risk_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubIndicatorRiskDataAdapter extends TypeAdapter<SubIndicatorRiskData> {
  @override
  final int typeId = 35;

  @override
  SubIndicatorRiskData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubIndicatorRiskData(
      data: (fields[0] as List?)?.cast<DataRiskDataModel>(),
      risk: fields[1] as Risk?,
      subIndicator: fields[2] as IndicatorModel?,
    );
  }

  @override
  void write(BinaryWriter writer, SubIndicatorRiskData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.risk)
      ..writeByte(2)
      ..write(obj.subIndicator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubIndicatorRiskDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubIndicatorRiskData _$SubIndicatorRiskDataFromJson(
        Map<String, dynamic> json) =>
    SubIndicatorRiskData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataRiskDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      risk: json['risk'] == null
          ? null
          : Risk.fromJson(json['risk'] as Map<String, dynamic>),
      subIndicator: json['subIndicator'] == null
          ? null
          : IndicatorModel.fromJson(
              json['subIndicator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubIndicatorRiskDataToJson(
        SubIndicatorRiskData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'risk': instance.risk,
      'subIndicator': instance.subIndicator,
    };
