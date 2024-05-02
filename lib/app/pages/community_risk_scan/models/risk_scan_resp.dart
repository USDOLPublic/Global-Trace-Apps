import 'package:json_annotation/json_annotation.dart';
part 'risk_scan_resp.g.dart';

@JsonSerializable()
class RiskScanResp {
  RiskScanResp({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.entityType,
    this.entityId,
    this.creatorId,
  });

  String? id;
  int? createdAt;
  int? updatedAt;
  String? entityType;
  String? entityId;
  String? creatorId;

  factory RiskScanResp.fromJson(Map<String, dynamic> json) =>
      _$RiskScanRespFromJson(json);
  Map<String, dynamic> toJson() => _$RiskScanRespToJson(this);
}
