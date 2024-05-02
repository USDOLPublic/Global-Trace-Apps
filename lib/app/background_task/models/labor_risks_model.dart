import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'labor_risks_model.g.dart';

@HiveType(typeId: ModelTypeDefine.indicatorItem)
@JsonSerializable()
class LaborRisksModel {
  @HiveField(0)
  IndicatorModel? indicator;
  @HiveField(1)
  IndicatorModel? subIndicator;
  @HiveField(2)
  SeverityModel? severity;
  @HiveField(3)
  String? id;
  LaborRisksModel({
    this.indicator,
    this.subIndicator,
    this.severity,
    this.id,
  });
  factory LaborRisksModel.fromJson(Map<String, dynamic> json) =>
      _$LaborRisksModelFromJson(json);

  Map<String, dynamic> toJson() => _$LaborRisksModelToJson(this);
  
  Map<String, dynamic> toRequest() {
    Map<String, dynamic> requesData = <String, dynamic>{};
    if (indicator != null) {
      requesData['indicatorId'] = indicator!.id;
    }
    if (subIndicator != null) {
      requesData['subIndicatorId'] = subIndicator!.id;
    }
    if (severity != null) {
      requesData['severity'] = severity!.value;
    }
    return requesData;
  }
}
