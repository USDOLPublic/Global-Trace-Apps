import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:usdol/app/core.dart';

class TutorialController {
  final UserModel userInfo;
  final Function(bool) onComplete;
  final bool isGridActions;
  List<TargetFocus> tutorialTargets = <TargetFocus>[];
  Map<String, GlobalKey> tutorialWidgetKey = {};
  late final TutorialCoachMark _tutorial;
  bool _isShowing = false;

  TutorialController({
    required this.userInfo,
    required this.onComplete,
    required this.isGridActions,
  }) {
    tutorialWidgetKey[TutorialStep.drawer] = GlobalKey();
    if (userInfo.hasPermission(PermissionActionDef.logPurchase)) {
      tutorialWidgetKey[TutorialStep.purchase] = GlobalKey();
    }
    if (userInfo.hasPermission(PermissionActionDef.logTransformations)) {
      tutorialWidgetKey[TutorialStep.transformation] = GlobalKey();
    }
    if (userInfo.hasPermission(PermissionActionDef.logByProduct)) {
      tutorialWidgetKey[TutorialStep.recordByProduct] = GlobalKey();
    }
    if (userInfo.hasPermission(PermissionActionDef.logSale)) {
      tutorialWidgetKey[TutorialStep.sell] = GlobalKey();
    }
    if (userInfo.hasPermission(PermissionActionDef.logTransport)) {
      tutorialWidgetKey[TutorialStep.transport] = GlobalKey();
    }
    if (userInfo.hasPermission(PermissionActionDef.viewReports)) {
      tutorialWidgetKey[TutorialStep.requestInfo] = GlobalKey();
    }
    if (userInfo.hasPermission(PermissionActionDef.submitReports) &&
        userInfo.hasPermission(PermissionActionDef.proactiveAssessments)) {
      tutorialWidgetKey[TutorialStep.communityRiskScan] = GlobalKey();
    }
  }

  void initTutorial() {
    tutorialTargets.clear();
    if (tutorialWidgetKey.isEmpty) return;
    int? drawerStep = _getStepNumber(TutorialStep.drawer);
    if (drawerStep != null) {
      tutorialTargets.add(
        _createTargetFocus(
          step: drawerStep,
          align: ContentAlign.bottom,
          message: userInfo.isProductUser()
              ? S.current.tutorialUpdatePersonalDetail
              : S.current.updateYourProfileHere,
          shape: ShapeLightFocus.Circle,
          isLeft: false,
        ),
      );
    }
    int? purchaseStep = _getStepNumber(TutorialStep.purchase);
    if (purchaseStep != null) {
      tutorialTargets.add(
        _createTargetFocus(
          step: purchaseStep,
          align: userInfo.isProductUser() && isGridActions
              ? ContentAlign.top
              : ContentAlign.bottom,
          message: S.current.tutorialRecordPurchases,
          shape: ShapeLightFocus.RRect,
          isLeft: isGridActions,
        ),
      );
    }

    int? transformationStep = _getStepNumber(TutorialStep.transformation);
    if (transformationStep != null) {
      tutorialTargets.add(
        _createTargetFocus(
          step: transformationStep,
          align: ContentAlign.top,
          message: S.current.tutorialRecordLotId,
          shape: ShapeLightFocus.RRect,
          isLeft: false,
        ),
      );
    }

    int? recordByProductStep = _getStepNumber(TutorialStep.recordByProduct);
    if (recordByProductStep != null) {
      tutorialTargets.add(
        _createTargetFocus(
          step: recordByProductStep,
          align: ContentAlign.top,
          message: S.current.tutorialRecordByProduct,
          shape: ShapeLightFocus.RRect,
          isLeft: false,
        ),
      );
    }

    int? sellStep = _getStepNumber(TutorialStep.sell);
    if (sellStep != null) {
      tutorialTargets.add(
        _createTargetFocus(
          step: sellStep,
          align: ContentAlign.top,
          message: S.current.tutorialSales,
          shape: ShapeLightFocus.RRect,
          isLeft: isGridActions,
        ),
      );
    }

    int? transportStep = _getStepNumber(TutorialStep.transport);
    if (transportStep != null) {
      tutorialTargets.add(
        _createTargetFocus(
          step: transportStep,
          align: ContentAlign.top,
          message: S.current.tutorialTransportation,
          shape: ShapeLightFocus.RRect,
          isLeft: false,
        ),
      );
    }

    int? requestInfoStep = _getStepNumber(TutorialStep.requestInfo);
    if (requestInfoStep != null) {
      tutorialTargets.add(
        _createTargetFocus(
          step: requestInfoStep,
          align: ContentAlign.bottom,
          message: S.current.messageTutorialRequest,
          shape: ShapeLightFocus.RRect,
          isLeft: isGridActions,
        ),
      );
    }

    int? communityRiskScanStep = _getStepNumber(TutorialStep.communityRiskScan);
    if (communityRiskScanStep != null) {
      tutorialTargets.add(_createTargetFocus(
        step: communityRiskScanStep,
        align: ContentAlign.top,
        message: S.current.tutorialSubmitCommunity,
        shape: ShapeLightFocus.RRect,
        isLeft: false,
      ));
    }
  }

  TargetFocus _createTargetFocus({
    required int step,
    required String message,
    required ShapeLightFocus shape,
    required ContentAlign align,
    bool isLeft = true,
  }) {
    GlobalKey? targetKey = getKeyOfStep(step);
    return TargetFocus(
      identify: "tutorial-$step",
      keyTarget: targetKey,
      alignSkip: Alignment.topRight,
      shape: shape,
      paddingFocus: 0,
      radius: AppProperties.circleRadius,
      contents: [
        TargetContent(
          align: align,
          builder: (context, controller) {
            return TutorialStepPopup(
                currentStep: step,
                totalSteps: tutorialWidgetKey.length,
                message: message,
                tutorialController: _tutorial,
                isLeft: isLeft,
                isTop: align != ContentAlign.top,
                onSwitchToStep: (stepNextFocus) async {
                  BuildContext? stepContext =
                      getKeyOfStep(stepNextFocus)?.currentContext;
                  if (stepContext != null) {
                    Scrollable.ensureVisible(stepContext);
                  }
                });
          },
        ),
      ],
    );
  }

  int? _getStepNumber(String stepKey) {
    if (tutorialWidgetKey.containsKey(stepKey)) {
      return tutorialWidgetKey.keys.toList().indexOf(stepKey) + 1;
    }
    return null;
  }

  GlobalKey? getKeyOfStepByKey(String stepKey) {
    if (tutorialWidgetKey.containsKey(stepKey)) {
      return tutorialWidgetKey[stepKey];
    }
    return null;
  }

  GlobalKey? getKeyOfStep(int stepNumber) {
    if (stepNumber - 1 < 0 ||
        stepNumber - 2 > tutorialWidgetKey.length ||
        tutorialWidgetKey.isEmpty) {
      return null;
    }
    return tutorialWidgetKey.values.toList()[stepNumber - 1];
  }

  void showTutorial(BuildContext context) {
    if (_isShowing) return;

    _tutorial = TutorialCoachMark(
      targets: tutorialTargets, // List<TargetFocus>
      hideSkip: true,
      // alignSkip: Alignment.bottomRight,
      // textSkip: "SKIP",
      // paddingFocus: 10,
      // focusAnimationDuration: Duration(milliseconds: 500),
      // pulseAnimationDuration: Duration(milliseconds: 500),
      pulseEnable: false,
      onFinish: () {
        LogUtil.d("[Tutorial] finish");
        _isShowing = false;
        onComplete(false);
      },
      onClickTarget: (target) {
        LogUtil.d("[Tutorial] target $target");
      },
      onSkip: () {
        LogUtil.d("[Tutorial] skip");
        _isShowing = false;
        onComplete(true);
        return true;
      },
    )..show(context: context);
    _isShowing = true;
  }
}

class TutorialStep {
  static const String drawer = "drawer";
  static const String purchase = "purchase";
  static const String transformation = "assign";
  static const String sell = "sell";
  static const String transport = "transport";
  static const String requestInfo = "requestInfo";
  static const String communityRiskScan = "communityRiskScan";
  static const String recordByProduct = "recordByProduct";
}
