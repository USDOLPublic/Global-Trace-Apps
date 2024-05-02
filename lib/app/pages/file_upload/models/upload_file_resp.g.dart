// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadFileResp _$UploadFileRespFromJson(Map<String, dynamic> json) =>
    UploadFileResp(
      blobName: json['blobName'] as String?,
      fileName: json['fileName'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$UploadFileRespToJson(UploadFileResp instance) =>
    <String, dynamic>{
      'blobName': instance.blobName,
      'fileName': instance.fileName,
      'url': instance.url,
    };
