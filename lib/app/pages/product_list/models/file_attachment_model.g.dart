// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_attachment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileAttachmentModelAdapter extends TypeAdapter<FileAttachmentModel> {
  @override
  final int typeId = 64;

  @override
  FileAttachmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileAttachmentModel(
      fileName: fields[1] as String?,
      link: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FileAttachmentModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.link)
      ..writeByte(1)
      ..write(obj.fileName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileAttachmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileAttachmentModel _$FileAttachmentModelFromJson(Map<String, dynamic> json) =>
    FileAttachmentModel(
      fileName: json['fileName'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$FileAttachmentModelToJson(
        FileAttachmentModel instance) =>
    <String, dynamic>{
      'link': instance.link,
      'fileName': instance.fileName,
    };
