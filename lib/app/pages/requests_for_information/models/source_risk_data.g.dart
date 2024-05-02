// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_risk_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SourceRiskDataAdapter extends TypeAdapter<SourceRiskData> {
  @override
  final int typeId = 34;

  @override
  SourceRiskData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SourceRiskData(
      risk: fields[0] as Risk?,
      source: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SourceRiskData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.risk)
      ..writeByte(1)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceRiskDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceRiskData _$SourceRiskDataFromJson(Map<String, dynamic> json) =>
    SourceRiskData(
      risk: json['risk'] == null
          ? null
          : Risk.fromJson(json['risk'] as Map<String, dynamic>),
      source: json['source'] as String?,
    );

Map<String, dynamic> _$SourceRiskDataToJson(SourceRiskData instance) =>
    <String, dynamic>{
      'risk': instance.risk,
      'source': instance.source,
    };
