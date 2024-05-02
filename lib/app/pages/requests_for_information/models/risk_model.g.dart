// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RiskAdapter extends TypeAdapter<Risk> {
  @override
  final int typeId = 33;

  @override
  Risk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Risk(
      level: fields[0] as String?,
      score: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Risk obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RiskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Risk _$RiskFromJson(Map<String, dynamic> json) => Risk(
      level: json['level'] as String?,
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RiskToJson(Risk instance) => <String, dynamic>{
      'level': instance.level,
      'score': instance.score,
    };
