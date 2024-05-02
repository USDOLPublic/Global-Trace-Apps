// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_risk_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataRiskDataModelAdapter extends TypeAdapter<DataRiskDataModel> {
  @override
  final int typeId = 30;

  @override
  DataRiskDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataRiskDataModel(
      note: fields[0] as String?,
      risk: fields[1] as Risk?,
      roleId: fields[2] as String?,
      source: fields[3] as String?,
      createdAt: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DataRiskDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.note)
      ..writeByte(1)
      ..write(obj.risk)
      ..writeByte(2)
      ..write(obj.roleId)
      ..writeByte(3)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataRiskDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataRiskDataModel _$DataRiskDataModelFromJson(Map<String, dynamic> json) =>
    DataRiskDataModel(
      note: json['note'] as String?,
      risk: json['risk'] == null
          ? null
          : Risk.fromJson(json['risk'] as Map<String, dynamic>),
      roleId: json['roleId'] as String?,
      source: json['source'] as String?,
      createdAt: json['createdAt'] as int?,
    );

Map<String, dynamic> _$DataRiskDataModelToJson(DataRiskDataModel instance) =>
    <String, dynamic>{
      'note': instance.note,
      'risk': instance.risk,
      'roleId': instance.roleId,
      'source': instance.source,
      'createdAt': instance.createdAt,
    };
