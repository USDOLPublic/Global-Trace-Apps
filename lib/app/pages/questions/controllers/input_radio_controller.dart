import 'package:usdol/app/core.dart';

class InputRadioController extends GetxController {
  SAQQuestion question;
  String index;
  List<SaqQuestionResponse>? respondOptions;
  SaqAnswerItem? answerData;
  Function(SaqAnswerItem?)? onChangeResponse;

  final RxList<SaqQuestionResponse> _itemSelected = <SaqQuestionResponse>[].obs;
  // ignore: invalid_use_of_protected_member
  List<SaqQuestionResponse> get itemSelected => _itemSelected.value;
  set itemSelected(List<SaqQuestionResponse> value) =>
      _itemSelected.value = value;

  InputRadioController({
    required this.question,
    this.index = '0',
    this.onChangeResponse,
    this.respondOptions,
    this.answerData,
  });

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
    super.onInit();
  }

  void onChooseItem(SaqQuestionResponse item) {
    itemSelected.clear();
    itemSelected.add(item);
    _itemSelected.refresh();
    onChangeResponse?.call(getAnswerFromSelection());
  }

  SaqAnswerItem? getAnswerFromSelection() {
    if (itemSelected.isEmpty) return null;
    String? answerId = answerData?.id;
    List<AnswerValue> answers = <AnswerValue>[];
    for (SaqQuestionResponse item in itemSelected) {
      answers.add(
        AnswerValue(
          value: item.id,
          questionResponse: item,
        ),
      );
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
