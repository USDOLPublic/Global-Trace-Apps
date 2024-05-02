import 'package:json_annotation/json_annotation.dart';
part 'margin_error_chart_resp.g.dart';

@JsonSerializable()
class MarginErrorChartResp {
  bool? canCalculate;
  double? value;

  MarginErrorChartResp({
    this.canCalculate,
    this.value,
  });

  factory MarginErrorChartResp.fromJson(Map<String, dynamic> json) =>
      _$MarginErrorChartRespFromJson(json);

  Map<String, dynamic> toJson() => _$MarginErrorChartRespToJson(this);

  bool get isCanCalculate => canCalculate == true;
}
