// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labor_risks_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LaborRisksModelAdapter extends TypeAdapter<LaborRisksModel> {
  @override
  final int typeId = 26;

  @override
  LaborRisksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LaborRisksModel(
      indicator: fields[0] as IndicatorModel?,
      subIndicator: fields[1] as IndicatorModel?,
      severity: fields[2] as SeverityModel?,
      id: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LaborRisksModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.indicator)
      ..writeByte(1)
      ..write(obj.subIndicator)
      ..writeByte(2)
      ..write(obj.severity)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaborRisksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaborRisksModel _$LaborRisksModelFromJson(Map<String, dynamic> json) =>
    LaborRisksModel(
      indicator: json['indicator'] == null
          ? null
          : IndicatorModel.fromJson(json['indicator'] as Map<String, dynamic>),
      subIndicator: json['subIndicator'] == null
          ? null
          : IndicatorModel.fromJson(
              json['subIndicator'] as Map<String, dynamic>),
      severity: json['severity'] == null
          ? null
          : SeverityModel.fromJson(json['severity'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$LaborRisksModelToJson(LaborRisksModel instance) =>
    <String, dynamic>{
      'indicator': instance.indicator,
      'subIndicator': instance.subIndicator,
      'severity': instance.severity,
      'id': instance.id,
    };
