import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class QuestionController extends GetxController {
  late final SAQCacheService _cacheService;
  late final SAQHttpService _httpService;
  late UserModel _user;
  SaqResp? _saqResp;
  List<SAQGroup>? questionGroup;
  final ScrollController scrollController = ScrollController();

  //group display
  final Rxn<SAQGroup> _currentGroup = Rxn<SAQGroup>();
  SAQGroup? get currentGroup => _currentGroup.value;
  set currentGroup(SAQGroup? value) => _currentGroup.value = value;

  final _indexGroup = 0.obs;
  int get indexGroup => _indexGroup.value;
  set indexGroup(int value) => _indexGroup.value = value;

  //list question of current group
  final RxList<SAQQuestion> _currentQuestionOfGroup = <SAQQuestion>[].obs;
  //ignore: invalid_use_of_protected_member
  List<SAQQuestion> get currentQuestionOfGroup => _currentQuestionOfGroup.value;
  set currentQuestionOfGroup(List<SAQQuestion> value) =>
      _currentQuestionOfGroup.value = value;

  //index of question type.
  final _indexQuestionInGroup = 0.obs;
  int get indexQuestionInGroup => _indexQuestionInGroup.value;
  set indexQuestionInGroup(int value) => _indexQuestionInGroup.value = value;

  final Rxn<SAQQuestion> _questionDisplay = Rxn<SAQQuestion>();
  //ignore: invalid_use_of_protected_member
  SAQQuestion? get questionDisplay => _questionDisplay.value;
  set questionDisplay(SAQQuestion? value) => _questionDisplay.value = value;

  final _isEnableSaveButton = false.obs;
  bool get isEnableSaveButton => _isEnableSaveButton.value;
  set isEnableSaveButton(bool value) => _isEnableSaveButton.value = value;

  final _isEnableBackButton = false.obs;
  bool get isEnableBackButton => _isEnableBackButton.value;
  set isEnableBackButton(bool value) => _isEnableBackButton.value = value;

  final _isEnableNextButton = true.obs;
  bool get isEnableNextButton => _isEnableNextButton.value;
  set isEnableNextButton(bool value) => _isEnableNextButton.value = value;

  final List<SAQGroup> _prevQuestions = <SAQGroup>[];
  List<SaqAnswerItem> _answerData = <SaqAnswerItem>[];
  SaqAnswerItem? _currentAnswer;
  bool isHaveChangedAnswer = false;

  @override
  void onInit() {
    _cacheService = Get.find<SAQCacheService>();
    _httpService = Get.find<SAQHttpService>();
    super.onInit();
  }

  @override
  void onReady() async {
    _initData();
    super.onReady();
  }

  Future<void> _initData() async {
    _user = MainController.to.userInfo;
    ProcessingDialog processingDialog = ProcessingDialog.show();
    await Future.wait([_loadQuestions(), _loadAnswers()]);
    processingDialog.hide();
    //init group
    questionGroup = _saqResp?.groups;
    indexGroup = 0;
    if (questionGroup == null || questionGroup!.isEmpty) {
      currentGroup = null;
      return;
    }
    currentGroup = questionGroup![indexGroup];
    for (var element in questionGroup!) {
      _prevQuestions.add(
        SAQGroup(
          id: element.id,
          title: element.title,
          order: element.order,
          questions: [],
        ),
      );
    }
    //init question
    indexQuestionInGroup = 0;
    if (currentGroup?.questions != null) {
      currentQuestionOfGroup = currentGroup!.questions;
    }
    if (currentQuestionOfGroup.isNotEmpty) {
      questionDisplay = currentQuestionOfGroup.first;
      _currentAnswer = getAnswerItem(questionDisplay!.id);
      _prevQuestions[indexQuestionInGroup].questions.add(questionDisplay!);
    }
    //state of button
    _updateActionState();
  }

  Future<void> _loadQuestions() async {
    final saqResult = await _httpService.getSelfAssessments();
    if (saqResult.isSuccess() && saqResult.data != null) {
      await _cacheService.saveSAQLatestData(
        _user.id,
        saqResult.response!.data! as Map<String, dynamic>,
      );
      _saqResp = saqResult.data;
    } else {
      String languageCode =
          Prefs.getString(Defines.languageKey, defaultValue: 'en');
      _saqResp = _cacheService.getSAQLatestInStorage(_user.id, languageCode);
    }
  }

  Future<void> _loadAnswers() async {
    final saqResult = await _httpService.getSAQAnswers();
    if (saqResult.isSuccess() && saqResult.data != null) {
      await _cacheService.saveSAQAnswerData(
        _user.id,
        saqResult.response!.data! as List<dynamic>,
      );
      _answerData = saqResult.data!;
    } else {
      _answerData = _cacheService.getSAQAnswerInStorage(_user.id) ?? [];
    }
  }

  int _addQuestionToPrevStack(int groupIdx, SAQQuestion? quest) {
    if (quest == null) {
      return 0;
    }
    int idxExisted = _prevQuestions[indexGroup].questions.indexWhere(
          (e) => e.id == quest.id,
        );
    if (idxExisted >= 0) {
      _prevQuestions[indexGroup].questions.removeRange(
            idxExisted,
            _prevQuestions[indexGroup].questions.length,
          );
    }
    _prevQuestions[indexGroup].questions.add(quest);
    return _prevQuestions[indexGroup].questions.length - 1;
  }

  void onGotoGroup(int index) {
    if (questionGroup == null ||
        questionGroup!.length <= index ||
        index < 0 ||
        index == indexGroup) {
      // Out of data
      return;
    }
    //handle
    indexGroup = index;
    currentGroup = questionGroup![indexGroup];
    currentQuestionOfGroup = currentGroup!.questions;
    if (_prevQuestions[indexGroup].questions.isNotEmpty) {
      int lastQuestInGroup = _prevQuestions[indexGroup].questions.length - 1;
      int noAnswerIdx = 0;
      for (var quest in _prevQuestions[indexGroup].questions) {
        if (!_isHaveAnswer(quest.id)) {
          lastQuestInGroup = noAnswerIdx;
          break;
        }
        noAnswerIdx++;
      }
      indexQuestionInGroup = lastQuestInGroup;
      questionDisplay =
          _prevQuestions[indexGroup].questions[indexQuestionInGroup];
      _prevQuestions[indexGroup].questions.removeRange(
            indexQuestionInGroup + 1,
            _prevQuestions[indexGroup].questions.length,
          );
    } else {
      indexQuestionInGroup = 0;
      questionDisplay = currentQuestionOfGroup.first;
      _addQuestionToPrevStack(indexGroup, questionDisplay!);
    }
    _currentAnswer = getAnswerItem(questionDisplay!.id);
    bool isLastQuestion = _isLastQuestion();

    while (_isHaveAnswer(questionDisplay!.id) && !isLastQuestion) {
      String? nextQuestionId = _getNextQuestionId();
      SAQQuestion? nextQuestion = currentQuestionOfGroup
          .firstWhereOrNull((element) => element.id == nextQuestionId);
      if (nextQuestionId == questionDisplay?.id || nextQuestion == null) {
        isLastQuestion = true;
        continue;
      }
      questionDisplay = nextQuestion;
      _currentAnswer = getAnswerItem(questionDisplay!.id);
      indexQuestionInGroup = _addQuestionToPrevStack(
        indexGroup,
        questionDisplay!,
      );
    }
    _updateActionState();
  }

  bool _isHaveAnswer(String questionId) {
    SaqAnswerItem? answer = getAnswerItem(questionId);
    if (answer == null) {
      return false;
    }
    List<AnswerValue> answers = answer.answers!;
    if (answers.isEmpty) {
      return false;
    }
    return answers.every((element) => element.isHaveAnswer());
  }

  SaqAnswerItem? getAnswerItem(String questionId) {
    return _answerData.firstWhereOrNull(
        (element) => element.selfAssessmentQuestionId == questionId);
  }

  void gotoPrevQuestion() {
    int oldIndexGroup = indexGroup;
    if (indexQuestionInGroup == 0) {
      // not available
      if (indexGroup == 0) {
        return;
      }
      indexGroup--;
      currentGroup = questionGroup![indexGroup];
      currentQuestionOfGroup = currentGroup!.questions;
      indexQuestionInGroup = _prevQuestions[indexGroup].questions.length;
    }
    _prevQuestions[oldIndexGroup].questions.removeLast();
    if (_prevQuestions[indexGroup].questions.isEmpty) {
      // not available
      return;
    }
    indexQuestionInGroup--;
    questionDisplay = _prevQuestions[indexGroup].questions.last;
    _currentAnswer = getAnswerItem(questionDisplay!.id);
    _updateActionState();
  }

  bool _isLastQuestion() {
    return _getNextQuestionId() == null;
  }

  void gotoNextQuestion() {
    String? nextQuestionId = _getNextQuestionId();
    SAQQuestion? nextQuestion = currentQuestionOfGroup
        .firstWhereOrNull((element) => element.id == nextQuestionId);
    if (nextQuestionId == questionDisplay?.id) {
      return;
    }
    if (nextQuestion != null) {
      questionDisplay = nextQuestion;
      _currentAnswer = getAnswerItem(questionDisplay!.id);
      _prevQuestions[indexGroup].questions.add(questionDisplay!);
      indexQuestionInGroup++;
    } else {
      indexGroup++;
      //check next group
      if (indexGroup >= questionGroup!.length) {
        //Out of group
        return;
      }
      currentGroup = questionGroup![indexGroup];
      currentQuestionOfGroup = currentGroup!.questions;
      indexQuestionInGroup = 0;
      if (currentQuestionOfGroup.isNotEmpty) {
        questionDisplay = currentQuestionOfGroup.first;
        _currentAnswer = getAnswerItem(questionDisplay!.id);
        _prevQuestions[indexGroup].questions.add(questionDisplay!);
      }
    }

    _updateActionState();
  }

  String? _getNextQuestionId() {
    if (_currentAnswer?.answers != null &&
        _currentAnswer!.answers!.isNotEmpty) {
      List<AnswerValue> responseSorted = List.from(_currentAnswer!.answers!);
      responseSorted.sort((a, b) => b.riskSort.compareTo(a.riskSort));
      return responseSorted.first.questionResponse?.nextQuestionId;
    }
    return questionDisplay?.getDefaultNextQuestion();
  }

  void _updateActionState() {
    isEnableBackButton = !(indexQuestionInGroup == 0 && indexGroup == 0);
    isEnableSaveButton =
        indexGroup == questionGroup!.length - 1 && _isLastQuestion();
    isEnableNextButton = !isEnableSaveButton;
  }

  //answer listener
  void onChooseAnswer(SaqAnswerItem? answerItem) {
    if (answerItem == null) {
      return;
    }
    _currentAnswer = answerItem;
    bool isExistedAnswer = false;
    for (var element in _answerData) {
      if (element.selfAssessmentQuestionId ==
          answerItem.selfAssessmentQuestionId) {
        element.answers = answerItem.answers;
        isExistedAnswer = true;
      }
    }
    if (!isExistedAnswer) {
      _answerData.add(answerItem);
    }
    isHaveChangedAnswer = true;
    _updateActionState();
  }

  Future<SAQResult> saveAnswers(SAQStatusEnum status) async {
    bool isProgressCompleted = true;
    String message = S.current.saqSuccessfullyCompleted;
    List<SaqSubmitResp>? submitResp;
    ProcessingDialog processing = ProcessingDialog.show();
    final submitAnsResult = await _httpService.submitSAQAnswers(
      SaqAnswerReq(answers: _answerData),
    );
    processing.hide();
    if (submitAnsResult.isSuccess()) {
      submitResp = submitAnsResult.data;
      if (submitResp!.isNotEmpty) {
        message = S.current.yourSAQCurrentProgressSaved;
      }
      _loadAnswers();
    } else {
      isProgressCompleted = false;
      message = submitAnsResult.getErrorMessage();
    }

    return SAQResult(
      isSuccess: isProgressCompleted,
      message: message,
      status: status,
      submitResp: submitResp,
    );
  }
}
