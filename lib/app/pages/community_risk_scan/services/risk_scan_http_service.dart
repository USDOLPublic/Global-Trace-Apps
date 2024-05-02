import 'package:usdol/app/core.dart';
class RiskScanHttpService extends BaseApiClient {
  Future<BaseResp<RiskScanResp>> addRiskScan(RiskScanRequest payload) async {
    
    return request<RiskScanResp>(
      Method.post,
      AppApi.addRiskScan,
      data: payload.toRequest(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          //Parse json (Map Type)
          return RiskScanResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<FacilityRespModel>>> searchFacility(String name) async {
    return request<List<FacilityRespModel>>(
      Method.get,
      AppApi.facilities + "?key=" + name,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue != null && jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  FacilityRespModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
