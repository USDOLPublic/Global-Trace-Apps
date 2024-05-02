import 'package:json_annotation/json_annotation.dart';
part 'chart_value.g.dart';

@JsonSerializable()
class ChartValue {
  bool? canCalculate;
  double? value;

  ChartValue({
    this.canCalculate,
    this.value,
  });

  factory ChartValue.fromJson(Map<String, dynamic> json) =>
      _$ChartValueFromJson(json);

  Map<String, dynamic> toJson() => _$ChartValueToJson(this);

  bool get isCanCalculate => canCalculate == true;
}
