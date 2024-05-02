import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'data_risk_data_model.g.dart';

@HiveType(typeId: ModelTypeDefine.dataRiskDataModel)
@JsonSerializable()
class DataRiskDataModel {
  DataRiskDataModel({
    this.note,
    this.risk,
    this.roleId,
    this.source,
    this.createdAt,
  });
  @HiveField(0)
  String? note;
  @HiveField(1)
  Risk? risk;
  @HiveField(2)
  String? roleId;
  @HiveField(3)
  String? source;
  @HiveField(4)
  int? createdAt;

  factory DataRiskDataModel.fromJson(Map<String, dynamic> json) =>
      _$DataRiskDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataRiskDataModelToJson(this);
}
