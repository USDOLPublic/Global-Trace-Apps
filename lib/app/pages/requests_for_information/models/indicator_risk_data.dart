import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'indicator_risk_data.g.dart';

@HiveType(typeId: ModelTypeDefine.indicatorRiskData)
@JsonSerializable()
class IndicatorRiskData {
  IndicatorRiskData({
    this.risk,
    this.indicator,
    this.subIndicatorRiskData,
  });
  @HiveField(0)
  Risk? risk;
  @HiveField(1)
  IndicatorModel? indicator;
  @HiveField(2)
  List<SubIndicatorRiskData>? subIndicatorRiskData;

  factory IndicatorRiskData.fromJson(Map<String, dynamic> json) =>
      _$IndicatorRiskDataFromJson(json);

  Map<String, dynamic> toJson() => _$IndicatorRiskDataToJson(this);
}
