import 'dart:async';
import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class HomeController extends GetxController {
  late final SessionManager _sessionManager;
  late final ProfileHttpService _profileHttp;
  late UserModel userInfo;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TutorialController? tutorialController;

  void Function(UserModel)? onUserInfoChanged;

  late Rx<InputItem> _langSelected;
  InputItem get langSelected => _langSelected.value;
  set langSelected(InputItem value) => _langSelected.value = value;

  List<InputItem> languageSupports = [];
  double cardRatio = 0;
  final double imgRatio = 312.0 / 62.0;
  final int numOfRow = 1;
  final double contentMargin = AppProperties.contentMargin;
  final double crossSpace = 0;

  @override
  void onInit() {
    _sessionManager = Get.find<SessionManager>();
    _profileHttp = Get.find<ProfileHttpService>();
    userInfo = MainController.to.userInfo;
    _calculatorItemInHome();
    _initLanguages();
    super.onInit();
  }

  void _calculatorItemInHome() {
    double widthOfImg = (Get.width - contentMargin - crossSpace) / numOfRow;
    double heightOfImg = widthOfImg / imgRatio;
    cardRatio = widthOfImg / (heightOfImg + 42);
  }

  void createTutorial(bool isGridView) {
    //Setup tutorial
    tutorialController = TutorialController(
      userInfo: userInfo,
      onComplete: (bool isSkip) {
        Prefs.saveBool(Defines.tutorialKey, true);
        _profileHttp.setFinishGuidance();
      },
      isGridActions: isGridView,
    );
  }

  Future<void> initTutorial(BuildContext context) async {
    bool isHaveShowTutorial = Prefs.getBool(Defines.tutorialKey);
    if (tutorialController == null) return;
    if (!isHaveShowTutorial && !userInfo.isCompletedTutorial()) {
      tutorialController?.initTutorial();
      await Future.delayed(const Duration(milliseconds: 500), () => null);
      if (tutorialController!.tutorialTargets.isNotEmpty) {
        tutorialController?.showTutorial(context);
      }
    }
  }

  Future<void> signOut() async {
    ProcessingDialog processing = ProcessingDialog.show();
    await _sessionManager.cleanSession();
    processing.hide();
    Get.offNamed<void>(Routes.login);
  }

  void checkUpdateUserInfo() {
    userInfo = MainController.to.userInfo;
    onUserInfoChanged?.call(userInfo);
  }

  void _initLanguages() {
    AppLanguage.supportLanguages.forEach((key, value) {
      languageSupports.add(
        InputItem(
          displayLabel: value.displayLabel,
          value: key,
          icon: value.value,
        ),
      );
    });

    String selected = Prefs.getString(
      Defines.languageKey,
      defaultValue: AppLanguage.defaultLanguage,
    );
    _langSelected = (languageSupports
                .firstWhereOrNull((element) => element.value == selected) ??
            InputItem(
              displayLabel: '',
              value: AppLanguage.defaultLanguage,
            ))
        .obs;
  }

  Future<void> changeLanguage(BuildContext context, InputItem? lang) async {
    if (lang == null) return;
    await Prefs.saveString(Defines.languageKey, lang.value);
    DioHelper.updateHeader(
      DioHelper.currentDio(),
      {
        "language": lang.value,
      },
    );
    await MyApp.of(context)?.setLanguage(lang.value, 'US');
    langSelected = lang;
  }

  bool isHavePermissionViewOverview() {
    return userInfo.isProductUser();
  }

  bool isHavePermissionViewHistory() {
    return userInfo.hasPermission(PermissionActionDef.viewHistory);
  }

  bool isHavePermissionManagePartners() {
    return userInfo.isProductUser() &&
        userInfo.hasPermission(
          PermissionActionDef.invitePartners,
        );
  }
}
