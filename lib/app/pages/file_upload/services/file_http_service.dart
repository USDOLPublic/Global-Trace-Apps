import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:usdol/app/core.dart';

class FileHttpService extends BaseApiClient {
  Future<BaseResp<List<UploadFileResp>>> uploadFiles(List<String> paths) async {
    Map<String, dynamic> data = <String, dynamic>{};
    List<MultipartFileExtended> filesData = <MultipartFileExtended>[];
    await Future.forEach(paths, (path) async {
      File fileData = File(path);
      if (await fileData.exists()) {
        MultipartFileExtended file = MultipartFileExtended.fromFileSync(
          path,
          filename: path.split('/').last,
          contentType: DioHelper.getMediaType(path),
        );
        filesData.add(file);
      }
    });

    if (filesData.isEmpty) {
      return BaseResp<List<UploadFileResp>>.withError(
        errorMsg: 'File not found!',
        statusCode: -1,
      );
    }

    data["files"] = filesData;

    dio.Options optCustom = dio.Options();
    optCustom.contentType = ("multipart/form-data");
    return request<List<UploadFileResp>>(
      Method.post,
      AppApi.uploadFile,
      data: dio.FormData.fromMap(data),
      options: optCustom,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          List<UploadFileResp> respData = <UploadFileResp>[];
          for (int i = 0; i < jsonValue.length; i++) {
            respData.add(
              UploadFileResp.fromJson(
                jsonValue[i] as Map<String, dynamic>,
                fileName: filesData[i].filename,
              ),
            );
          }
          return respData;
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<int>>> downloadFile(
    String path, {
    void Function(int, int)? onReceiveProgress,
  }) async {
    dio.Options options = dio.Options();
    options.responseType = dio.ResponseType.bytes;
    dio.Dio myDio = dio.Dio();
    try {
      Uri uri = Uri.parse(path);
      myDio.options.baseUrl = uri.origin;
      var res = await myDio.get<List<int>>(
        uri.toString().replaceAll(uri.origin, ""),
        options: options,
        onReceiveProgress: onReceiveProgress,
      );
      return BaseResp(
        data: res.data!,
        statusCode: res.statusCode!,
        response: res,
      );
    } catch (e) {
      return BaseResp.withError(errorMsg: "errorMsg");
    }
  }
}
