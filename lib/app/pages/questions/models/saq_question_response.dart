import 'package:usdol/app/core.dart';

class SaqQuestionResponse {
  final String id;
  final int? createdAt;
  final int? updatedAt;
  final String? selfAssessmentQuestionId;
  final String? option;
  final String? optionType;
  final String? nextQuestionId;
  final int? goTo;
  final int? riskLevel;
  final String? indicatorId;
  final String? subIndicatorId;
  final SAQLabel? translation;
  //default enabled
  bool isEnable = true;

  SaqQuestionResponse({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.selfAssessmentQuestionId,
    this.option,
    this.optionType,
    this.nextQuestionId,
    this.goTo,
    this.riskLevel,
    this.indicatorId,
    this.subIndicatorId,
    this.translation,
  });

  factory SaqQuestionResponse.fromJson(dynamic json,
          {String language = "en"}) =>
      SaqQuestionResponse(
        id: (json["id"] ?? '') as String,
        createdAt: (json["createdAt"] ?? 0) as int?,
        updatedAt: (json["updatedAt"] ?? 0) as int?,
        selfAssessmentQuestionId: json["selfAssessmentQuestionId"] as String?,
        option: json["option"] as String?,
        optionType: json["optionType"] as String?,
        nextQuestionId: json["nextQuestionId"] as String?,
        goTo: (json["goTo"] ?? 0) as int?,
        riskLevel: (json["riskLevel"] ?? 0) as int?,
        indicatorId: json["indicatorId"] as String?,
        subIndicatorId: json["subIndicatorId"] as String?,
        translation: json["translation"] == null
            ? null
            : SAQLabel.fromJson(json["translation"], language: language),
      );

  bool isOtherResponse() {
    return optionType == 'Other';
  }

  int getRiskSort() {
    return riskLevel ?? -1;
  }
}
