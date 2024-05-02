import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'labor_risk_model_resp.g.dart';

@HiveType(typeId: ModelTypeDefine.laborRisk)
@JsonSerializable()
class LaborRisksResp {
  @HiveField(0)
  String? indicatorId;
  @HiveField(1)
  String? subIndicatorId;
  @HiveField(2)
  String? id;
  @HiveField(3)
  int? createdAt;
  @HiveField(4)
  int? updatedAt;
  @HiveField(5)
  String? entityId;
  @HiveField(6)
  String? entityType;
  @HiveField(7)
  String? creatorId;
  @HiveField(8)
  int? severity;
  @HiveField(9)
  IndicatorModel? indicator;
  @HiveField(10)
  IndicatorModel? subIndicator;
  LaborRisksResp({
    this.indicatorId,
    this.subIndicatorId,
    this.createdAt,
    this.creatorId,
    this.entityId,
    this.entityType,
    this.id,
    this.indicator,
    this.severity,
    this.subIndicator,
    this.updatedAt,
  });
  factory LaborRisksResp.fromJson(Map<String, dynamic> json) =>
      _$LaborRisksRespFromJson(json);

  Map<String, dynamic> toJson() => _$LaborRisksRespToJson(this);

  Map<String, dynamic> toRequest() {
    Map<String, dynamic> requestData = <String, dynamic>{};
    if (indicator != null) {
      requestData['indicatorId'] = indicator!.id;
    }
    if (subIndicator != null) {
      requestData['subIndicatorId'] = subIndicator!.id;
    }
    if (severity != null) {
      requestData['severity'] = severity;
    }
    return requestData;
  }
}
