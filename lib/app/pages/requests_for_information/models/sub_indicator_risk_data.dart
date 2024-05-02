import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sub_indicator_risk_data.g.dart';

@HiveType(typeId: ModelTypeDefine.subIndicatorRisk)
@JsonSerializable()
class SubIndicatorRiskData {
  SubIndicatorRiskData({
    this.data,
    this.risk,
    this.subIndicator,
  });
  @HiveField(0)
  List<DataRiskDataModel>? data;
  @HiveField(1)
  Risk? risk;
  @HiveField(2)
  IndicatorModel? subIndicator;
  factory SubIndicatorRiskData.fromJson(Map<String, dynamic> json) =>
      _$SubIndicatorRiskDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubIndicatorRiskDataToJson(this);
}
