import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'source_risk_data.g.dart';

@HiveType(typeId: ModelTypeDefine.sourceRiskData)
@JsonSerializable()
class SourceRiskData {
  SourceRiskData({
    this.risk,
    this.source,
  });
  @HiveField(0)
  Risk? risk;
  @HiveField(1)
  String? source;
  factory SourceRiskData.fromJson(Map<String, dynamic> json) =>
      _$SourceRiskDataFromJson(json);

  Map<String, dynamic> toJson() => _$SourceRiskDataToJson(this);
}
