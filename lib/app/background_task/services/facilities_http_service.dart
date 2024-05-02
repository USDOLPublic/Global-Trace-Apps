import 'package:usdol/app/core.dart';

class FacilitiesHttpService extends BaseApiClient {
  Future<BaseResp<List<IndicatorModel>>> getIndicators({
    RequestIndicator? paramIndicator,
  }) {
    return request<List<IndicatorModel>>(
      Method.get,
      AppApi.facilitiesIndicators,
      queryParameters: paramIndicator?.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue.map(
            (dynamic e) {
              var indicator =
                  IndicatorModel.fromJson(e as Map<String, dynamic>);
              return indicator;
            },
          ).toList();
        } else {
          return null;
        }
      },
    );
  }
}
