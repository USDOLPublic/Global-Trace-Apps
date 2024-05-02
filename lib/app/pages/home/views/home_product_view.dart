import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class HomeProductView extends GetView<HomeProductController> {
  const HomeProductView({super.key});

  void _purchaseOnClicked(BuildContext context) async {
    final dynamic result = await Get.toNamed<dynamic>(Routes.purchase);
    if (result != null && result is String && result.isNotEmpty) {
      _showPopupNotice(context, result);
      controller.transactionOnUpdate();
    }
  }

  void _transformationOnClicked(BuildContext context) async {
    final dynamic result = await Get.toNamed<dynamic>(Routes.transformation);
    if (result != null && result is String && result.isNotEmpty) {
      _showPopupNotice(context, result);
    }
  }

  void _sellOnClicked(BuildContext context) async {
    final dynamic result = await Get.toNamed<dynamic>(Routes.sell);
    if (result != null && result is String && result.isNotEmpty) {
      _showPopupNotice(context, result);
      controller.transactionOnUpdate();
    }
  }

  void _recordProductOnClicked(BuildContext context) async {
    final dynamic result = await Get.toNamed<dynamic>(Routes.recordByProduct);
    if (result != null && result is String && result.isNotEmpty) {
      _showPopupNotice(context, result);
      controller.transactionOnUpdate();
    }
  }

  void _transportOnClicked(BuildContext context) async {
    final dynamic result = await Get.toNamed<dynamic>(Routes.transport);
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

  bool _hasPermission(String permissionName) {
    return controller.hasPermission(permissionName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const DashboardChartView(),
          _buildProductMenuActions(context, false),
        ],
      ),
    );
  }

  Widget _buildProductMenuActions(BuildContext context, bool isGridView) {
    TutorialController? tutorialController = controller.tutorialController;
    final List<Widget> listHomeCard = <Widget>[];

    ///
    /// Purchase product
    ///
    if (_hasPermission(PermissionActionDef.logPurchase)) {
      listHomeCard.add(
        HomeCardAction(
          cardKey: tutorialController?.getKeyOfStepByKey(
            TutorialStep.purchase,
          ),
          aspectRatio: controller.imgRatio,
          assetPath:
              isGridView ? AssetsConst.icSmallPurchase : AssetsConst.icPurchase,
          title: S.of(context).purchase,
          onTap: () => _purchaseOnClicked(context),
        ),
      );
    }

    ///
    /// Transform product
    ///
    if (_hasPermission(PermissionActionDef.logTransformations)) {
      listHomeCard.add(
        HomeCardAction(
          cardKey: tutorialController?.getKeyOfStepByKey(
            TutorialStep.transformation,
          ),
          aspectRatio: controller.imgRatio,
          assetPath:
              isGridView ? AssetsConst.icSmallAssign : AssetsConst.icAssign,
          title: S.of(context).transformation,
          onTap: () => _transformationOnClicked(context),
        ),
      );
    }

    ///
    /// Record product
    ///
    if (_hasPermission(PermissionActionDef.logByProduct)) {
      listHomeCard.add(
        HomeCardAction(
          cardKey: tutorialController?.getKeyOfStepByKey(
            TutorialStep.recordByProduct,
          ),
          aspectRatio: controller.imgRatio,
          assetPath: AssetsConst.recordByProduct,
          title: S.of(context).recordByProduct,
          onTap: () => _recordProductOnClicked(context),
        ),
      );
    }

    ///
    /// Sell product
    ///
    if (_hasPermission(PermissionActionDef.logSale)) {
      listHomeCard.add(
        HomeCardAction(
          cardKey: tutorialController?.getKeyOfStepByKey(
            TutorialStep.sell,
          ),
          aspectRatio: controller.imgRatio,
          assetPath: isGridView ? AssetsConst.icSmallSell : AssetsConst.icSell,
          title: S.of(context).sell,
          onTap: () => _sellOnClicked(context),
        ),
      );
    }

    ///
    /// Transport product
    ///
    if (_hasPermission(PermissionActionDef.logTransport)) {
      listHomeCard.add(
        HomeCardAction(
          cardKey: tutorialController?.getKeyOfStepByKey(
            TutorialStep.transport,
          ),
          aspectRatio: controller.imgRatio,
          assetPath: isGridView
              ? AssetsConst.icSmallTransport
              : AssetsConst.icTransport,
          title: S.of(context).transport,
          onTap: () => _transportOnClicked(context),
        ),
      );
    }

    if (listHomeCard.isEmpty) {
      return const EmptyPage();
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppProperties.circleRadius),
        ),
      ),
      padding: EdgeInsets.all(controller.contentMargin),
      child: GridView.count(
        crossAxisCount: controller.numOfRow,
        childAspectRatio: controller.cardRatio,
        crossAxisSpacing: controller.crossSpace,
        mainAxisSpacing: controller.contentMargin,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: listHomeCard,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
