// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labor_risk_model_resp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LaborRisksRespAdapter extends TypeAdapter<LaborRisksResp> {
  @override
  final int typeId = 29;

  @override
  LaborRisksResp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LaborRisksResp(
      indicatorId: fields[0] as String?,
      subIndicatorId: fields[1] as String?,
      createdAt: fields[3] as int?,
      creatorId: fields[7] as String?,
      entityId: fields[5] as String?,
      entityType: fields[6] as String?,
      id: fields[2] as String?,
      indicator: fields[9] as IndicatorModel?,
      severity: fields[8] as int?,
      subIndicator: fields[10] as IndicatorModel?,
      updatedAt: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LaborRisksResp obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.indicatorId)
      ..writeByte(1)
      ..write(obj.subIndicatorId)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.entityId)
      ..writeByte(6)
      ..write(obj.entityType)
      ..writeByte(7)
      ..write(obj.creatorId)
      ..writeByte(8)
      ..write(obj.severity)
      ..writeByte(9)
      ..write(obj.indicator)
      ..writeByte(10)
      ..write(obj.subIndicator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaborRisksRespAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaborRisksResp _$LaborRisksRespFromJson(Map<String, dynamic> json) =>
    LaborRisksResp(
      indicatorId: json['indicatorId'] as String?,
      subIndicatorId: json['subIndicatorId'] as String?,
      createdAt: json['createdAt'] as int?,
      creatorId: json['creatorId'] as String?,
      entityId: json['entityId'] as String?,
      entityType: json['entityType'] as String?,
      id: json['id'] as String?,
      indicator: json['indicator'] == null
          ? null
          : IndicatorModel.fromJson(json['indicator'] as Map<String, dynamic>),
      severity: json['severity'] as int?,
      subIndicator: json['subIndicator'] == null
          ? null
          : IndicatorModel.fromJson(
              json['subIndicator'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$LaborRisksRespToJson(LaborRisksResp instance) =>
    <String, dynamic>{
      'indicatorId': instance.indicatorId,
      'subIndicatorId': instance.subIndicatorId,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'entityId': instance.entityId,
      'entityType': instance.entityType,
      'creatorId': instance.creatorId,
      'severity': instance.severity,
      'indicator': instance.indicator,
      'subIndicator': instance.subIndicator,
    };
