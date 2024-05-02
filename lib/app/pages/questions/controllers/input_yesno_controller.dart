import 'package:usdol/app/core.dart';

class InputYesNoController extends GetxController {
  final SAQQuestion question;
  final String index;
  final List<SaqQuestionResponse>? respondOptions;
  SaqAnswerItem? answerData;
  Function(SaqAnswerItem?)? onChangeResponse;

  final Rxn<SaqQuestionResponse> _selectedTab = Rxn<SaqQuestionResponse>();
  SaqQuestionResponse? get selectedTab => _selectedTab.value;
  set selectedTab(SaqQuestionResponse? value) => _selectedTab.value = value;

  InputYesNoController({
    required this.index,
    required this.question,
    this.respondOptions,
    this.answerData,
    this.onChangeResponse,
  });

  @override
  void onInit() {
    selectedTab = getSelectionFromAnswer();
    super.onInit();
  }

  void onChangeTab(SaqQuestionResponse tab) {
    selectedTab = tab;
    onChangeResponse?.call(getAnswerFromSelection());
  }

  SaqQuestionResponse? getSelectionFromAnswer() {
    if (answerData?.answers == null || answerData!.answers!.isEmpty) {
      return null;
    }
    List<AnswerValue> answerValue = answerData!.answers!;
    AnswerValue ansItem = answerValue.first;
    return ansItem.questionResponse;
  }

  SaqAnswerItem? getAnswerFromSelection() {
    if (selectedTab == null) return null;
    String? answerId = answerData?.id;
    List<AnswerValue> answers = <AnswerValue>[];
    answers.add(AnswerValue(
      value: selectedTab!.id,
      questionResponse: selectedTab,
    ));

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
