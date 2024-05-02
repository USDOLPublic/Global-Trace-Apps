import 'package:usdol/app/core.dart';

class SAQHttpService extends BaseApiClient {
  Future<BaseResp<SaqResp>> getSelfAssessments() async {
    String languageCode =
        service.options.headers['language']?.toString() ?? 'en';
    return request<SaqResp>(
      Method.get,
      AppApi.selfAssessments,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map<String, dynamic>) {
          return SaqResp.fromJson(jsonValue, language: languageCode);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<SaqAnswerItem>>> getSAQAnswers() async {
    return request<List<SaqAnswerItem>>(
      Method.get,
      AppApi.selfAssessmentAnswers,
      onDeserialize: (dynamic jsonValue) {
        //Parse json (List Type)
        if (jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  SaqAnswerItem.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<SaqSubmitResp>>> submitSAQAnswers(
      SaqAnswerReq answer) async {
    return request<List<SaqSubmitResp>>(
      Method.post,
      AppApi.selfAssessmentAnswers,
      data: answer.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue.map(
            (dynamic e) {
              var submitResp =
                  SaqSubmitResp.fromJson(e as Map<String, dynamic>);
              return submitResp;
            },
          ).toList();
        } else {
          return null;
        }
      },
    );
  }
}
