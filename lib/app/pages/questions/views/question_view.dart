import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';
import 'package:usdol/app/pages/questions/views/incomplete_widget.dart';

class QuestionView extends GetView<QuestionController> {
  const QuestionView({Key? key}) : super(key: key);

  void _onTapIndicator(int index) {
    controller.onGotoGroup(index);
  }

  void _submitAnswerOnClicked(BuildContext context) async {
    final SAQResult saqResult = await controller.saveAnswers(
      SAQStatusEnum.completed,
    );
    _handleSubmitResult(context, saqResult);
  }

  void _handleSubmitResult(BuildContext context, SAQResult saqResult) {
    switch (saqResult.status) {
      case SAQStatusEnum.none:
      case SAQStatusEnum.draft:
        Get.back(result: saqResult);
        break;
      case SAQStatusEnum.completed:
        if (saqResult.isSuccess) {
          if (saqResult.submitResp == null || saqResult.submitResp!.isEmpty) {
            Get.back(result: saqResult);
          } else {
            _showIncompleteInfo(context, saqResult.submitResp!);
          }
        } else {
          SnackBars.error(message: saqResult.message).show(duration: 5000);
        }
        break;
    }
  }

  void _showIncompleteInfo(
    BuildContext context,
    List<SaqSubmitResp> submitResp,
  ) {
    Get.dialog<void>(
      BasePopup(
        title: const SizedBox.shrink(),
        body: InCompleteWidget(incompleteList: submitResp),
        isSmallAlert: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back<void>();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(S.of(context).ok.toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }

  void _appBarBackOnClicked() async {
    SAQResult? saqResult;
    if (controller.isHaveChangedAnswer) {
      saqResult = await controller.saveAnswers(
        SAQStatusEnum.draft,
      );
    }
    Get.back(result: saqResult);
  }

  void _backOnClicked() {
    controller.gotoPrevQuestion();
  }

  void _nextOnClicked() {
    controller.gotoNextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: QuestionAppBar(
          body: Obx(
            () => QuestionAppBarBody(
              title: S.of(context).selfAssessmentQuestionnaire,
              onBack: _appBarBackOnClicked,
              indexSelected: (controller.indexGroup + 1),
              length: controller.questionGroup?.length ?? 0,
              onTapIndicator: _onTapIndicator,
            ),
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Text(
                  controller.currentGroup?.title.value ?? "",
                  style: const TextStyle(
                    color: AppColors.grey600,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Obx(
                  () {
                    List<Widget> contentWidgets = <Widget>[];
                    SAQQuestion? _questionDisplay = controller.questionDisplay;
                    if (_questionDisplay != null) {
                      contentWidgets.add(
                        InputAnswerBuilder(
                          question: _questionDisplay,
                          answerItem: controller.getAnswerItem(_questionDisplay.id),
                          onChangeAnswer: controller.onChooseAnswer,
                          index: (_questionDisplay.order).toString(),
                        ),
                      );
                    }

                    contentWidgets.add(_buildSubmitSAQ(context));
                    return ListView(
                      key: const ValueKey("questionScroll"),
                      physics: const BouncingScrollPhysics(),
                      controller: controller.scrollController,
                      children: contentWidgets,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => _buildBottomAction(context, controller.questionDisplay != null),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context, bool visible) {
    return Visibility(
      visible: visible,
      child: BottomAction(
        childContent: Row(
          children: [
            Obx(
              () {
                bool enable = controller.isEnableBackButton;
                return _buildBottomDirectAction(
                  context,
                  key: const ValueKey('backButton'),
                  isEnable: enable,
                  onPressed: _backOnClicked,
                  label: S.of(context).back,
                );
              },
            ),
            const Expanded(child: SizedBox.shrink()),
            Obx(
              () {
                return _buildBottomDirectAction(
                  context,
                  key: const ValueKey('nextButton'),
                  onPressed: _nextOnClicked,
                  label: S.of(context).next,
                  isDirectToLeft: false,
                  isEnable: controller.isEnableNextButton,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomDirectAction(
    BuildContext context, {
    Key? key,
    bool isEnable = true,
    String label = "",
    bool isDirectToLeft = true,
    required void Function()? onPressed,
  }) {
    if (!isEnable) return const SizedBox.shrink();
    return InkWell(
      key: key,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
        child: Row(
          children: [
            if (isDirectToLeft) const Icon(Icons.arrow_back_ios_rounded),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey600,
                ),
              ),
            ),
            if (!isDirectToLeft) const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitSAQ(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Obx(() {
        if (controller.isEnableSaveButton) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              key: const ValueKey("submitSAQ"),
              child: Text(S.of(context).submit),
              onPressed: () => _submitAnswerOnClicked(context),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
