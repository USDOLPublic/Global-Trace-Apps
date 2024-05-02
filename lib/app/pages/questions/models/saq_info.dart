import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saq_info.g.dart';
@JsonSerializable()
class SAQInfo {
  SAQInfo({
    required this.forFacilityId,
    required this.id,
    this.completedSaqAt,
    this.isDraft,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  int? createdAt;
  int? updatedAt;
  String forFacilityId;
  int? completedSaqAt;
  bool? isDraft;

  factory SAQInfo.fromJson(Map<String, dynamic> json) =>
      _$SAQInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SAQInfoToJson(this);

  SAQStatusEnum getSAQStatus() {
    if (isDraft == true) {
      return SAQStatusEnum.draft;
    }

    if (completedSaqAt != null && completedSaqAt != 0) {
      return SAQStatusEnum.completed;
    }
    return SAQStatusEnum.none;
  }
}
