import 'package:usdol/app/pages/questions/models/saq_answer_value.dart';

class SaqAnswerItem {
  SaqAnswerItem({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.selfAssessmentId,
    this.groupId,
    this.selfAssessmentQuestionId,
    this.isDraft,
    this.answers,
    this.deletedAt,
  });

  String? id;
  int? createdAt;
  int? updatedAt;
  String? selfAssessmentId;
  String? groupId;
  String? selfAssessmentQuestionId;
  bool? isDraft;
  List<AnswerValue>? answers;
  int? deletedAt;

  factory SaqAnswerItem.fromJson(Map<String, dynamic> json) => SaqAnswerItem(
        id: (json["id"] ?? "").toString(),
        createdAt: json["createdAt"] == null ? null : json["createdAt"]! as int?,
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"]! as int?,
        selfAssessmentId: (json["selfAssessmentId"] ?? "").toString(),
        groupId: (json["groupId"] ?? "").toString(),
        selfAssessmentQuestionId: (json["selfAssessmentQuestionId"] ?? "").toString(),
        isDraft: (json["isDraft"] ?? true) as bool,
        deletedAt: json["deletedAt"] == null ? null : json["deletedAt"]! as int?,
        answers: json["answers"] == null
            ? null
            : List<AnswerValue>.from((json["answers"] as List).map<AnswerValue>((dynamic x) => AnswerValue.fromJson(x as Map<String, dynamic>))),
      );

  Map<String, dynamic> toRequest() => <String, dynamic>{
        "selfAssessmentQuestionId": selfAssessmentQuestionId,
        "answerValues": answers == null ? null : List<dynamic>.from(answers!.map<dynamic>((x) => x.toRequest())),
      };
}
