import 'package:usdol/app/core.dart';

class HistoryHttpService extends BaseApiClient {
  Future<BaseResp<HistoryResp>> getHistories(HistoryReq req) {
    return request<HistoryResp>(
      Method.get,
      AppApi.getHistory,
      queryParameters: req.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          //Parse json (Map Type)
          return HistoryResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }
}
