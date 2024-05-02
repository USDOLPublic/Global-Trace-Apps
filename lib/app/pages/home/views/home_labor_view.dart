import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class HomeLaborView extends GetView<HomeLaborController> {
  const HomeLaborView({Key? key}) : super(key: key);

  void _requestInformationOnClicked(BuildContext context) {
    Get.toNamed<dynamic>(Routes.requestsInfo);
  }

  void _communityRiskScanOnClicked(BuildContext context) async {
    final dynamic result = await Get.toNamed<dynamic>(Routes.communityRiskScan);
    if (result != null && result is String && result.isNotEmpty) {
      _showPopupNotice(context, result);
    }
  }

  void _showPopupNotice(BuildContext context, String message) {
    Get.dialog<void>(
      BasePopup(
        title: const SizedBox.shrink(),
        body: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
        isSmallAlert: true,
        actions: [
          TextButton(
            key: const ValueKey("confirmNotice"),
            onPressed: () async {
              Get.back<void>();
            },
            child: Text(S.of(context).ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildFarmMonitorMenuActions(context);
  }

  Widget _buildFarmMonitorMenuActions(BuildContext context) {
    TutorialController? tutorialController = controller.tutorialController;
    final List<Widget> listHomeAction = <Widget>[];

    if (controller.hasViewReport()) {
      listHomeAction.add(
        HomeCardAction(
          key: const ValueKey("requestForInformation"),
          cardKey: tutorialController?.getKeyOfStepByKey(
            TutorialStep.requestInfo,
          ),
          aspectRatio: controller.imgRatio,
          assetPath: AssetsConst.icRequest,
          title: S.of(context).requestHome,
          onTap: () => _requestInformationOnClicked(context),
        ),
      );
    }
    if (controller.hasCommunityRiskScanSubmit()) {
      listHomeAction.add(
        HomeCardAction(
          cardKey: tutorialController?.getKeyOfStepByKey(
            TutorialStep.communityRiskScan,
          ),
          aspectRatio: controller.imgRatio,
          assetPath: AssetsConst.icScan,
          title: S.of(context).communityRiskScan,
          onTap: () => _communityRiskScanOnClicked(context),
        ),
      );
    }
    if (listHomeAction.isEmpty) {
      return const EmptyPage();
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: controller.contentMargin),
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: controller.cardRatio,
          mainAxisSpacing: controller.contentMargin,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: listHomeAction,
        ),
      ),
    );
  }
}
