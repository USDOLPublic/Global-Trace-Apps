import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class InputCheckboxController extends GetxController {
  SAQQuestion question;
  String index;
  final Rxn<List<SaqQuestionResponse>> _respondOptions =
      Rxn<List<SaqQuestionResponse>>();
  // ignore: invalid_use_of_protected_member
  List<SaqQuestionResponse>? get respondOptions => _respondOptions.value;
  set respondOptions(List<SaqQuestionResponse>? value) =>
      _respondOptions.value = value;

  SaqAnswerItem? answerData;
  Function(SaqAnswerItem?)? onChangeResponse;

  final RxList<SaqQuestionResponse> _itemSelected = <SaqQuestionResponse>[].obs;
  // ignore: invalid_use_of_protected_member
  List<SaqQuestionResponse> get itemSelected => _itemSelected.value;
  set itemSelected(List<SaqQuestionResponse> value) =>
      _itemSelected.value = value;

  final TextEditingController textController = TextEditingController();

  InputCheckboxController({
    required this.question,
    this.index = '0',
    this.onChangeResponse,
    this.answerData,
  }) {
    respondOptions = question.questionResponses;
  }

  @override
  void onInit() {
    itemSelected = [];
    List<AnswerValue>? answersInit = answerData?.answers;
    if (answersInit != null) {
      for (var element in answersInit) {
        if (element.questionResponse != null) {
          itemSelected.add(element.questionResponse!);
        }
      }
    }
    //init value for other
    SaqQuestionResponse? otherOption = respondOptions?.firstWhereOrNull(
        (SaqQuestionResponse element) => element.isOtherResponse());

    if (otherOption != null) {
      AnswerValue? otherAns = answersInit?.firstWhereOrNull(
          (AnswerValue element) =>
              element.questionResponse?.id == otherOption.id);

      if (otherAns?.value != null && otherAns!.value is String) {
        textController.text = otherAns.value.toString();
      }
    }
    //init specific
    _updateSpecificOptionChoose();
    super.onInit();
  }

  void onChooseItem(SaqQuestionResponse item, {bool isInput = false}) {
    if (isInput) {
      onChangeResponse?.call(getAnswerFromSelection());
    } else {
      final selected =
          itemSelected.where((element) => item.id == element.id).toList();
      if (selected.isNotEmpty) {
        itemSelected.removeWhere((element) => element.id == item.id);
      } else {
        itemSelected.add(item);
      }
      _updateSpecificOptionChoose();
      _itemSelected.refresh();
      onChangeResponse?.call(getAnswerFromSelection());
    }
  }

  void _updateSpecificOptionChoose() {
    bool isHaveOtherOption =
        itemSelected.firstWhereOrNull((element) => element.isOtherResponse()) !=
            null;
    if (isHaveOtherOption) {
      itemSelected.removeWhere((element) => !element.isOtherResponse());
      respondOptions?.forEach((SaqQuestionResponse element) {
        element.isEnable = element.isOtherResponse();
      });
    } else {
      respondOptions?.forEach((SaqQuestionResponse element) {
        element.isEnable = true;
      });
    }
    _respondOptions.refresh();
  }

  SaqAnswerItem? getAnswerFromSelection() {
    String? answerId = answerData?.id;
    List<AnswerValue> answers = <AnswerValue>[];
    for (SaqQuestionResponse response in itemSelected) {
      AnswerValue answer = AnswerValue(
        questionResponse: response,
      );
      if (response.isOtherResponse()) {
        answer.value = textController.text.trim();
      } else {
        answer.value = response.id;
      }
      answers.add(answer);
    }

    SaqAnswerItem? answerItem = SaqAnswerItem(
      id: answerId ?? "",
      selfAssessmentId: answerData?.selfAssessmentId ?? "",
      groupId: answerData?.groupId ?? "",
      selfAssessmentQuestionId: question.id,
      isDraft: answerData?.isDraft ?? true,
      answers: answers,
    );
    return answerItem;
  }
}
