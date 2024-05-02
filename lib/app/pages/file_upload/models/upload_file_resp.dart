import 'package:json_annotation/json_annotation.dart';
part 'upload_file_resp.g.dart';

@JsonSerializable()
class UploadFileResp {
  UploadFileResp({
    this.blobName,
    this.fileName,
    this.url,
  });

  String? blobName;
  String? fileName;
  String? url;

  factory UploadFileResp.fromJson(
    Map<String, dynamic> json, {
    String? fileName,
  }) {
    UploadFileResp fileResp = _$UploadFileRespFromJson(json);
    fileResp.fileName = fileName;
    return fileResp;
  }

  Map<String, dynamic> toJson() => _$UploadFileRespToJson(this);
}
