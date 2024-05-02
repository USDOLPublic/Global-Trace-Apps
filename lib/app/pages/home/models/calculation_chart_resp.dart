import 'package:json_annotation/json_annotation.dart';
import 'chart_value.dart';
part 'calculation_chart_resp.g.dart';

@JsonSerializable()
class CalculationChartResp {
  ChartValue? totalInputs;
  ChartValue? totalOutputs;
  ChartValue? totalByProduct;

  CalculationChartResp({
    this.totalByProduct,
    this.totalInputs,
    this.totalOutputs,
  });

  factory CalculationChartResp.fromJson(Map<String, dynamic> json) =>
      _$CalculationChartRespFromJson(json);

  Map<String, dynamic> toJson() => _$CalculationChartRespToJson(this);
}
