import 'package:usdol/app/core.dart';

class RequestInformationHttpService extends BaseApiClient {
  Future<BaseResp<RequestInfoResp>> getRequestInformation(
      RequestInformationReq req) {
    return request<RequestInfoResp>(
      Method.get,
      AppApi.grievanceReport,
      queryParameters: req.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          //Parse json (Map Type)
          return RequestInfoResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> viewRequestInformation(String reportId) {
    return request<dynamic>(
      Method.get,
      AppApi.viewReport(reportId),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<dynamic>> responseToRequest(
    RespondModel req,
    String reportId,
  ) async {
    return request<dynamic>(
      Method.post,
      AppApi.reportResponse(reportId),
      data: req.toRequest(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
