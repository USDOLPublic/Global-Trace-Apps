import 'package:usdol/app/core.dart';

class OverviewHttpService extends BaseApiClient {

  Future<BaseResp<MassBalanceChartResp>> massBalanceChart(
      ChartFilterReq filter) {
    return request<MassBalanceChartResp>(
      Method.get,
      AppApi.calculationMassBalanceChart,
      queryParameters: filter.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return MassBalanceChartResp.fromJson(
            jsonValue as Map<String, dynamic>,
          );
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<MarginErrorChartResp>> marginErrorChart(
      ChartFilterReq filter) {
    return request<MarginErrorChartResp>(
      Method.get,
      AppApi.calculationMarginOfError,
      queryParameters: filter.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return MarginErrorChartResp.fromJson(
            jsonValue as Map<String, dynamic>,
          );
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<CalculationChartResp>> calculationChart(
      ChartFilterReq filter) {
    return request<CalculationChartResp>(
      Method.get,
      AppApi.calculationProductTradeChart,
      queryParameters: filter.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return CalculationChartResp.fromJson(
            jsonValue as Map<String, dynamic>,
          );
        } else {
          return null;
        }
      },
    );
  }
}
