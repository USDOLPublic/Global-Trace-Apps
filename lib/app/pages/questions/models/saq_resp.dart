import 'package:usdol/app/core.dart';

class SaqResp {
  SaqResp({
    this.selfAssessment,
    this.groups,
  });

  SAQInfo? selfAssessment;
  List<SAQGroup>? groups;

  factory SaqResp.fromJson(Map<String, dynamic> json, {String language = "en"}) => SaqResp(
        selfAssessment: json["selfAssessment"] == null ? null : SAQInfo.fromJson(json["selfAssessment"] as Map<String, dynamic>),
        groups: json["groups"] == null
            ? null
            : List<SAQGroup>.from(
                (json["groups"] as List).map<SAQGroup>(
                  (dynamic x) => SAQGroup.fromJson(x as Map<String, dynamic>, language: language),
                ),
              ),
      );
}
