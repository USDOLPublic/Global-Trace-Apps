import 'package:usdol/app/core.dart';

class AnswerValue {
  AnswerValue({
    this.value,
    this.questionResponse,
  });

  dynamic value;
  SaqQuestionResponse? questionResponse;

  int get riskSort => questionResponse?.getRiskSort() ?? -1;

  factory AnswerValue.fromJson(Map<String, dynamic> json) {
    dynamic value = json["value"];
    return AnswerValue(
      value: value,
      questionResponse: SaqQuestionResponse.fromJson(
        json["questionResponse"],
      ),
    );
  }

  Map<String, dynamic> toRequest() {
    var mapData = <String, dynamic>{
      "value": value.toString(),
      "isOther": questionResponse?.isOtherResponse() ?? false,
      "selfAssessmentQuestionResponseId": questionResponse?.id
    };
    return mapData;
  }

  bool isHaveAnswer() {
    return value != null && value!.toString() != '';
  }
}
