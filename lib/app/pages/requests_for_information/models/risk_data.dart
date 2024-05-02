import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'risk_data.g.dart';

@HiveType(typeId: ModelTypeDefine.riskData)
@JsonSerializable()
class RiskData {
  RiskData({
    this.risk,
    this.category,
    this.sourceRiskData,
    this.indicatorRiskData,
  });
  @HiveField(0)
  Risk? risk;
  @HiveField(1)
  IndicatorModel? category;
  @HiveField(2)
  List<SourceRiskData>? sourceRiskData;
  @HiveField(3)
  List<IndicatorRiskData>? indicatorRiskData;

  factory RiskData.fromJson(Map<String, dynamic> json) => _$RiskDataFromJson(json);

  Map<String, dynamic> toJson() => _$RiskDataToJson(this);
}
