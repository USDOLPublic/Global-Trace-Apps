import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({Key? key}) : super(key: key);

  void _onTapSignOut() {
    controller.signOut();
  }

  void _nextOnClicked(bool isEnable) {
    if (isEnable) {
      controller.gotoHomePage();
    }
  }

  void _myProfileBtnOnClicked() async {
    controller.onTapMyProfile();
  }

  void _selfAssessmentBtnOnClicked() async {
    controller.onTapSelfAssessmentQuestion();
  }

  void _manageBusinessBtnOnClicked() async {
    controller.onTapManagePartner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawerEnableOpenDragGesture: true,
      appBar: AppBar(
        title: Text(S.of(context).onBoard),
        actions: [
          MenuEndDrawerIcon(
            scaffoldKey: controller.scaffoldKey,
          )
        ],
        elevation: 0,
      ),
      body: _buildOnBoardBody(context),
      endDrawer: DrawerView(
        userInfo: MainController.to.userInfo,
        onTapSignOut: _onTapSignOut,
        onTapProfile: _myProfileBtnOnClicked,
      ),
    );
  }

  Widget _buildOnBoardBody(BuildContext context) {
    return Obx(() {
      if (controller.profile.id.isEmpty) {
        return const SizedBox.shrink();
      }
      return _buildProductOnboard(context);
    });
  }

  Widget _buildProductOnboard(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppProperties.contentMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).pleaseFinishTheFollowing,
            textAlign: TextAlign.left,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _buildProductTasks(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppProperties.contentMargin),
            child: SizedBox(
              width: double.infinity,
              child: Obx(
                () {
                  bool isEnableBtn = controller.isCompletedTasks;
                  ButtonStyle nextBtnStyle = ElevatedBtnStyle.disable();
                  if (isEnableBtn) {
                    nextBtnStyle = ElevatedBtnStyle.enable();
                  }
                  return ElevatedButton(
                    onPressed: () => _nextOnClicked(isEnableBtn),
                    style: nextBtnStyle,
                    child: Text(
                      S.of(context).next,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTasks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppProperties.contentMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => controller.hasRequiredProfile
                ? _buildTaskSelect(
                    context,
                    index: 1,
                    label: S.of(context).myProfile,
                    icon: _buildOtherStatus(
                        (controller.profile.updatedProfileAt ?? 0) != 0),
                    onTab: _myProfileBtnOnClicked,
                    valueKey: const ValueKey<String>("profile"),
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.hasRequiredSAQ
                ? _buildTaskSelect(
                    context,
                    index: 2,
                    label: S.of(context).selfAssessmentQuestionnaire,
                    icon: _buildSAQStatus(controller.saqStatus),
                    onTab: _selfAssessmentBtnOnClicked,
                    valueKey: const ValueKey<String>("saqQuestion"),
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.hasManagePartner
                ? _buildTaskSelect(
                    context,
                    index: controller.hasRequiredSAQ == true ? 3 : 2,
                    label: S.of(context).manageBusinessPartners,
                    onTab: _manageBusinessBtnOnClicked,
                    icon: _buildOtherStatus(
                        (controller.profile.addedPartnerAt ?? 0) != 0),
                    valueKey: const ValueKey<String>("managePartner"),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSelect(
    BuildContext context, {
    int index = 1,
    String label = "",
    Widget? icon,
    Function()? onTab,
    required ValueKey valueKey,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: InkWell(
        key: valueKey,
        onTap: onTab,
        borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppProperties.contentMargin),
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => controller.hasRequiredSAQ || controller.hasManagePartner
                      ? Text(
                          "$index. ",
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: AppColors.grey200,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 3,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColors.grey600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                icon ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtherStatus(bool isComplete) {
    if (isComplete) {
      return const Icon(
        Icons.check_circle,
        color: AppColors.green700,
      );
    }

    return const Icon(
      Icons.radio_button_off_outlined,
      color: AppColors.grey200,
    );
  }

  Widget _buildSAQStatus(SAQStatusEnum saqStatus) {
    if (saqStatus == SAQStatusEnum.none) {
      return const Icon(
        Icons.radio_button_off_outlined,
        color: AppColors.grey200,
      );
    }

    if (saqStatus == SAQStatusEnum.completed) {
      return const Icon(
        Icons.check_circle,
        color: AppColors.green700,
      );
    }

    return const Icon(
      Icons.check_circle,
      color: AppColors.grey200,
    );
  }
}
