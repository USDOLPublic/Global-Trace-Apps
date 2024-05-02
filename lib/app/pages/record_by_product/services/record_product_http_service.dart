import 'package:usdol/app/core.dart';
import 'package:dio/dio.dart' as dio;

class RecordProductHttpService extends BaseApiClient {
  Future<BaseResp<dynamic>> logRecordByProduct(
    RecordProductRequest payload,
  ) async {
    final isConnected = await NetworkUtil.isConnected();
    if (!isConnected) {
      return BaseResp<dynamic>.withError(
        errorMsg: S.current.noInternetConnection,
        statusCode: status408RequestTimeout,
      );
    }
    Map<String, dynamic> mapData = payload.toRequest();
    List<MultipartFileExtended> files = <MultipartFileExtended>[];
    await Future.forEach(payload.uploadProofs, (String path) async {
      MultipartFileExtended file = MultipartFileExtended.fromFileSync(
        path,
        filename: path.split('/').last,
        contentType: DioHelper.getMediaType(path),
      );
      files.add(file);
    });
    mapData["uploadProofs"] = files;
    dio.Options optCustom = dio.Options();
    optCustom.contentType = ("multipart/form-data");
    return request<dynamic>(
      Method.post,
      AppApi.recordByProduct,
      data: dio.FormData.fromMap(mapData),
      options: optCustom,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
