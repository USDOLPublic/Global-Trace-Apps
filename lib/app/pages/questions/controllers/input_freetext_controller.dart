import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class InputFreeTextController extends GetxController {
  SAQQuestion question;
  String index;
  List<SaqQuestionResponse>? respondOptions;
  SaqAnswerItem? answerData;
  Function(SaqAnswerItem?)? onChangeResponse;

  final textController = TextEditingController();

  InputFreeTextController({
    required this.question,
    this.index = '0',
    this.onChangeResponse,
    this.respondOptions,
    this.answerData,
  });

  String get textInputValue => textController.text.trim();

  @override
  void onInit() {
    textController.text = getSelectionFromAnswer() ?? "";
    super.onInit();
  }

  void onChangeAnswer() {
    onChangeResponse?.call(getAnswerFromSelection());
  }

  String? inputValidation(String? value) {
    return null;
  }

  String? getSelectionFromAnswer() {
    if (answerData?.answers == null || answerData!.answers!.isEmpty) {
      return null;
    }
    List<AnswerValue> answerValue = answerData!.answers!;
    AnswerValue ansItem = answerValue.first;
    SAQLabel inputData = SAQLabel(data: <String, dynamic>{}, value: "");
    if (ansItem.value is Map<String, dynamic>) {
      inputData = SAQLabel.fromJson(ansItem.value);
    } else if (ansItem.value is String) {
      inputData = SAQLabel.fromString(ansItem.value.toString());
    }
    return inputData.value;
  }

  SaqAnswerItem? getAnswerFromSelection() {
    if (inputValidation(textController.text.trim()) != null) return null;
    String? answerId = answerData?.id;
    SaqQuestionResponse? respondOption;
    if (respondOptions != null && respondOptions!.isNotEmpty) {
      respondOption = respondOptions!.first;
    }
    List<AnswerValue> answers = <AnswerValue>[];
    if (textInputValue.isNotEmpty) {
      answers.add(AnswerValue(
        value: textInputValue,
        questionResponse: respondOption,
      ));
    }
    SaqAnswerItem answerItem = SaqAnswerItem(
      id: answerId ?? "",
      selfAssessmentId: answerData?.selfAssessmentId ?? "",
      groupId: answerData?.groupId ?? "",
      selfAssessmentQuestionId: question.id,
      isDraft: answerData?.isDraft ?? true,
      answers: answers,
    );
    return answerItem;
  }

  String getHintText() {
    if (respondOptions != null && respondOptions!.isNotEmpty) {
      return respondOptions?.first.translation?.value ?? '';
    }
    return "";
  }
}
