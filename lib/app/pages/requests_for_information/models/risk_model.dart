import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'risk_model.g.dart';

@HiveType(typeId: ModelTypeDefine.riskModel)
@JsonSerializable()
class Risk {
  Risk({
    this.level,
    this.score,
  });
  @HiveField(0)
  String? level;
  @HiveField(1)
  double? score;
  factory Risk.fromJson(Map<String, dynamic> json) => _$RiskFromJson(json);

  Map<String, dynamic> toJson() => _$RiskToJson(this);
}
