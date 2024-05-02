import 'package:usdol/app/core.dart';
import 'package:usdol/app/pages/page.dart';

class SAQQuestion {
  SAQQuestion({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.groupId,
    required this.title,
    required this.order,
    required this.type,
    required this.isRequired,
    this.questionResponses,
  });

  String id;
  int? createdAt;
  int? updatedAt;
  String groupId;
  SAQLabel title;
  int order;
  String type;
  bool isRequired;
  List<SaqQuestionResponse>? questionResponses;

  //SaqAnswerItem? answerItem;

  factory SAQQuestion.fromJson(Map<String, dynamic> json,
      {String language = "en"}) {
    return SAQQuestion(
      id: (json["id"] ?? "").toString(),
      createdAt: (json["createdAt"] ?? 0) as int,
      updatedAt: (json["updatedAt"] ?? 0) as int,
      groupId: (json["groupId"] ?? "").toString(),
      title: SAQLabel.fromJson(json["title"], language: language),
      order: (json["order"] ?? 0) as int,
      type: (json["type"] ?? "").toString(),
      isRequired: (json["isRequired"] ?? 0) as bool,
      questionResponses: json["questionResponses"] == null
          ? null
          : List<SaqQuestionResponse>.from((json["questionResponses"] as List)
              .map<SaqQuestionResponse>(
                  (dynamic x) => SaqQuestionResponse.fromJson(
                        x,
                        language: language,
                      ))),
    );
  }

  String? getDefaultNextQuestion() {
    if (questionResponses == null || questionResponses!.isEmpty) {
      return null;
    }
    List<SaqQuestionResponse> responseSorted = List.from(questionResponses!);
    responseSorted.sort((a, b) => b.getRiskSort().compareTo(a.getRiskSort()));
    return responseSorted.first.nextQuestionId;
  }
}
