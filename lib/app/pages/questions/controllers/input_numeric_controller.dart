import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class InputNumericController extends GetxController {
  SAQQuestion question;
  String index;
  List<SaqQuestionResponse>? respondOptions;
  SaqAnswerItem? answerData;
  Function(SaqAnswerItem?)? onChangeResponse;

  List<TextEditingController> textControllers = [];

  InputNumericController({
    required this.question,
    this.index = '0',
    this.onChangeResponse,
    this.respondOptions,
    this.answerData,
  });

  @override
  void onInit() {
    for (int i = 0; i < (respondOptions?.length ?? 0); i++) {
      final textController = TextEditingController();
      textController.text = getSelectionFromAnswer(respondOptions![i].id) ?? "";
      textControllers.add(textController);
    }
    super.onInit();
  }

  int? textInputValue(TextEditingController cont) {
    String textValue = cont.text.trim();
    textValue = textValue.replaceAll(",", "");
    return int.tryParse(textValue);
  }

  void onChangeAnswer() {
    onChangeResponse?.call(getAnswerFromSelection());
  }

  String? numericValidation(String? value) {
    if (value != null &&
        value.trim().isNotEmpty &&
        int.tryParse(value.trim().replaceAll(",", "")) == null) {
      return S.current.numericInvalid;
    }
    return null;
  }

  bool _isValidated() {
    for (var item in textControllers) {
      if (item.text.trim().isNotEmpty &&
          numericValidation(item.text.trim()) != null) {
        return false;
      }
    }
    return true;
  }

  String? getSelectionFromAnswer(String id) {
    if (answerData?.answers == null || answerData!.answers!.isEmpty) {
      return null;
    }
    List<AnswerValue> answerValue = answerData!.answers!;
    AnswerValue? ansItem = answerValue
        .firstWhereOrNull((element) => element.questionResponse?.id == id);
    if (ansItem == null) return null;
    return ansItem.value.toString();
  }

  SaqAnswerItem? getAnswerFromSelection() {
    if (!_isValidated() || textControllers.isEmpty || respondOptions == null) {
      return null;
    }
    String? answerId = answerData?.id;
    List<AnswerValue> answersData = <AnswerValue>[];
    for (int i = 0; i < respondOptions!.length; i++) {
      int? ansValue = textInputValue(textControllers[i]);
      answersData.add(
        AnswerValue(
          value: ansValue ?? '',
          questionResponse: respondOptions![i],
        ),
      );
    }

    SaqAnswerItem? answerItem = SaqAnswerItem(
      id: answerId ?? "",
      selfAssessmentId: answerData?.selfAssessmentId ?? "",
      groupId: answerData?.groupId ?? "",
      selfAssessmentQuestionId: question.id,
      isDraft: answerData?.isDraft ?? true,
      answers: answersData,
    );
    return answerItem;
  }
}
