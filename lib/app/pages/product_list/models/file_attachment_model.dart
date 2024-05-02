import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'file_attachment_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.fileAttachmentUpload)
class FileAttachmentModel extends HiveObject {
  FileAttachmentModel({
    this.fileName,
    this.link,
  });
  @HiveField(0)
  String? link;
  @HiveField(1)
  String? fileName;

  factory FileAttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$FileAttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileAttachmentModelToJson(this);
}
