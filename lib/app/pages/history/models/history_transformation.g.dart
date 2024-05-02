// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_transformation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryTransformationAdapter extends TypeAdapter<HistoryTransformation> {
  @override
  final int typeId = 44;

  @override
  HistoryTransformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryTransformation(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      facilityId: fields[3] as String?,
      uploadCertifications: (fields[4] as List?)?.cast<FileAttachmentModel>(),
      transformationItems: (fields[5] as List?)?.cast<TransformationItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, HistoryTransformation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.facilityId)
      ..writeByte(4)
      ..write(obj.uploadCertifications)
      ..writeByte(5)
      ..write(obj.transformationItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryTransformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryTransformation _$HistoryTransformationFromJson(
        Map<String, dynamic> json) =>
    HistoryTransformation(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      facilityId: json['facilityId'] as String?,
      uploadCertifications: (json['uploadCertifications'] as List<dynamic>?)
          ?.map((e) => FileAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      transformationItems: (json['transformationItems'] as List<dynamic>?)
          ?.map((e) => TransformationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryTransformationToJson(
        HistoryTransformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'facilityId': instance.facilityId,
      'uploadCertifications': instance.uploadCertifications,
      'transformationItems': instance.transformationItems,
    };
