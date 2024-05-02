import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';
import 'test_utils.dart';

class SAQQuestionRobot {
  const SAQQuestionRobot(this.tester);
  final WidgetTester tester;

  Future<void> openScreen() async {
    tester.printToConsole("======== Start SAQ Test ========");
    await addDelay(1000);
    await tester.tap(find.byKey(const ValueKey('saqQuestion')));
    await tester.pumpAndSettle();
    expect(find.text("Self Assessment Questionnaire"), findsOneWidget);
    tester.printToConsole("======== Open Screen Success ========");
  }

  Future<void> updateSAQQuestion() async {
    tester.printToConsole("======== Start Update SAQ Question ========");
    QuestionController questionController = Get.find<QuestionController>();
    await addDelay(1000);
    await _updatePageQuest(questionController);

    await tester.pumpAndSettle();
    await scrollThePage(tester, scrollKey: 'questionScroll');
    await tester.pumpAndSettle();
    final submitBtn = find.byKey(const ValueKey('submitSAQ'));
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.text('Onboard'), findsWidgets);
  }

  Future<void> _updatePageQuest(QuestionController cont) async {
    //ans
    if (cont.questionDisplay != null) {
      await _updateAnsQuestion(cont.questionDisplay!);
    }

    await tester.pumpAndSettle();
    if (!cont.isEnableSaveButton) {
      final nextBtn = find.byKey(const ValueKey('nextButton'));
      await tester.tap(nextBtn);
      await tester.pumpAndSettle();
      await addDelay(500);
      await _updatePageQuest(cont);
    }
  }

  Future<void> _updateAnsQuestion(SAQQuestion quest) async {
    switch (quest.type) {
      case QuestionType.checkbox:
        await _updateCheckboxQuest(quest);
        break;
      case QuestionType.freeText:
        await _updateFreetextQuest(quest);
        break;
      case QuestionType.numeric:
        await _updateNumericQuest(quest);
        break;
      case QuestionType.radio:
        await _updateRadioQuest(quest);
        break;
      case QuestionType.yesNo:
        await _updateYesNoQuest(quest);
        break;
      default:
    }
    await tester.pumpAndSettle();
  }

  Future<void> _updateCheckboxQuest(SAQQuestion quest) async {
    int numOfAns = quest.questionResponses?.length ?? -1;
    if (numOfAns < 0) return;
    int randIdx = getRandomInt(0, numOfAns);
    String ansId = quest.id + quest.questionResponses![randIdx].id;
    Finder ansFinder = find.byKey(ValueKey(ansId));
    await scrollThePageTo(tester, ansFinder, scrollKey: 'questionScroll');
    await tester.tap(ansFinder);
    await tester.pumpAndSettle();
  }

  Future<void> _updateRadioQuest(SAQQuestion quest) async {
    int numOfAns = quest.questionResponses?.length ?? -1;
    if (numOfAns < 0) return;
    int randIdx = getRandomInt(0, numOfAns);
    String ansId = quest.id + quest.questionResponses![randIdx].id;
    Finder ansFinder = find.byKey(ValueKey(ansId));
    await scrollThePageTo(tester, ansFinder, scrollKey: 'questionScroll');
    await tester.tap(ansFinder);
    await tester.pumpAndSettle();
  }

  Future<void> _updateYesNoQuest(SAQQuestion quest) async {
    int numOfAns = quest.questionResponses?.length ?? -1;
    if (numOfAns < 0) return;
    int randIdx = getRandomInt(0, numOfAns);
    String ansId = quest.id + quest.questionResponses![randIdx].id;
    Finder ansFinder = find.byKey(ValueKey(ansId));
    await scrollThePageTo(tester, ansFinder, scrollKey: 'questionScroll');
    await tester.tap(ansFinder);
    await tester.pumpAndSettle();
  }

  Future<void> _updateFreetextQuest(SAQQuestion quest) async {
    String ansId = quest.id;

    Finder ansFinder = find.byKey(ValueKey(ansId));
    //await scrollThePageTo(tester, ansFinder, scrollKey: 'questionScroll');
    await tester.enterText(ansFinder, getRandomString(10));
    await tester.pumpAndSettle();
  }

  Future<void> _updateNumericQuest(SAQQuestion quest) async {
    int numOfAns = quest.questionResponses?.length ?? -1;
    if (numOfAns < 0) return;
    int randIdx = getRandomInt(0, numOfAns);
    String ansId = quest.id + quest.questionResponses![randIdx].id;
    Finder ansFinder = find.byKey(ValueKey(ansId));
    //await scrollThePageTo(tester, ansFinder, scrollKey: 'questionScroll');
    await tester.enterText(ansFinder, getRandomInt(1, 100).toString());
    await tester.pumpAndSettle();
  }
}
