import 'package:usdol/app/core.dart';

class SAQGroup {
  SAQGroup({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.title,
    required this.order,
    required this.questions,
  });

  String id;
  int? createdAt;
  int? updatedAt;
  SAQLabel title;
  int order;
  List<SAQQuestion> questions;

  factory SAQGroup.fromJson(
    Map<String, dynamic> json, {
    String language = "en",
  }) {
    SAQGroup saqGroup = SAQGroup(
      id: (json["id"] ?? "").toString(),
      createdAt: (json["createdAt"] ?? 0) as int?,
      updatedAt: (json["updatedAt"] ?? 0) as int?,
      title: SAQLabel.fromJson(json["title"], language: language),
      order: (json["order"] ?? 0) as int,
      questions: json["questions"] == null
          ? []
          : List<SAQQuestion>.from(
              (json["questions"] as List).map<SAQQuestion>(
                (dynamic x) => SAQQuestion.fromJson(
                  x as Map<String, dynamic>,
                  language: language,
                ),
              ),
            ),
    );
    saqGroup.sortQuestionInGroup();
    return saqGroup;
  }

  void sortQuestionInGroup() {
    questions.sort((a, b) => a.order.compareTo(b.order));
  }
}
