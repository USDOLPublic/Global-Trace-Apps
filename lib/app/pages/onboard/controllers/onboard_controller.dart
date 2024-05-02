import 'dart:async';

import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class OnboardController extends GetxController {
  late final SessionManager _sessionManager;
  late final AuthHttpService _authHttpService;
  late final SAQCacheService _saqCacheService;
  late final SAQHttpService _saqHttpService;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _isCompletedTasks = false.obs;
  bool get isCompletedTasks => _isCompletedTasks.value;
  set isCompletedTasks(bool value) => _isCompletedTasks.value = value;

  final _profile = UserModel(id: '').obs;
  UserModel get profile => _profile.value;
  set profile(UserModel value) => _profile.value = value;

  late final ProfileHttpService _profileHttpService;
  late final UserCacheService _userCacheService;
  late final MainController _mainController;

  final RxBool _hasRequiredProfile = false.obs;
  set hasRequiredProfile(bool value) => _hasRequiredProfile.value = value;
  bool get hasRequiredProfile => _hasRequiredProfile.value;

  final RxBool _hasRequiredSAQ = false.obs;
  set hasRequiredSAQ(bool value) => _hasRequiredSAQ.value = value;
  bool get hasRequiredSAQ => _hasRequiredSAQ.value;

  final RxBool _hasManagePartner = false.obs;
  set hasManagePartner(bool value) => _hasManagePartner.value = value;
  bool get hasManagePartner => _hasManagePartner.value;

  late Rx<InputItem> _langSelected;
  InputItem get langSelected => _langSelected.value;
  set langSelected(InputItem value) => _langSelected.value = value;

  List<InputItem> languageSupports = [];

  StreamSubscription? _subUserInfo;
  SaqResp? _saqData;
  final Rx<SAQStatusEnum> _saqStatus = SAQStatusEnum.none.obs;
  set saqStatus(SAQStatusEnum value) => _saqStatus.value = value;
  SAQStatusEnum get saqStatus => _saqStatus.value;

  @override
  void onInit() {
    _sessionManager = Get.find<SessionManager>();
    _authHttpService = Get.find<AuthHttpService>();
    _profileHttpService = Get.find<ProfileHttpService>();
    _userCacheService = Get.find<UserCacheService>();
    _saqCacheService = Get.find<SAQCacheService>();
    _saqHttpService = Get.find<SAQHttpService>();
    _mainController = MainController.to;
    _initLanguages();
    _subUserInfo = _userCacheService.userRepo.dataStream
        .listen((Map<String, UserModel> event) {
      if (event.isNotEmpty) {
        profile = event.values.toList().first;
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    _fetchStatus(isDisplayLoading: true);
    super.onReady();
  }

  @override
  void onClose() async {
    await _subUserInfo?.cancel();
    super.onClose();
  }

  Future<void> signOut() async {
    ProcessingDialog processing = ProcessingDialog.show();
    await _sessionManager.cleanSession();
    await _authHttpService.logout();
    processing.hide();
    Get.offNamed<void>(Routes.login);
  }

  void gotoHomePage() {
    if (profile.isProductUser()) {
      Get.offNamed<void>(Routes.homeProduct);
    } else {
      Get.offNamed<void>(Routes.homeLabor);
    }
  }

  Future<void> _fetchProfile() async {
    String errorMessage = '';
    final res = await _profileHttpService.loadProfile();
    if (res.isSuccess() && res.data != null) {
      UserModel user = res.data!;
      _initActionPermission(user);
      bool isUserValidated = _isUserValidated(user);
      if (isUserValidated) {
        await _userCacheService.userRepo.put(user.id, user);
        isCompletedTasks = await _mainController.checkCompletedTask();
      } else {
        errorMessage = S.current.notSupportBusiness;
      }
    } else {
      errorMessage = res.getErrorMessage(
        defaultErrMessage: S.current.genericErrorDescriptionShort,
      );
    }
    if (errorMessage.isNotEmpty) {
      SnackBars.error(message: errorMessage).show();
    }
  }

  void _initActionPermission(UserModel user) {
    hasRequiredProfile =
        user.hasPermission(PermissionActionDef.completeOwnProfile);
    hasRequiredSAQ = user.hasPermission(PermissionActionDef.completeOwnSaq);
    hasManagePartner = user.hasPermission(PermissionActionDef.invitePartners);
  }

  bool _isUserValidated(UserModel? user) {
    if (user != null) {
      return user.isMobileSupported();
    } else {
      return false;
    }
  }

  void onTapMyProfile() async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.editProfile,
      arguments: EditProfileArguments(
        pageTitle: S.current.myProfile,
        type: EditProfileType.fromOnboard,
        profile: profile,
      ),
    );
    if (result == true) {
      _fetchProfile();
      SnackBars.complete(message: S.current.profileSuccessfully)
          .show(duration: 5000);
    }
  }

  void onTapManagePartner() async {
    final dynamic result =
        await Get.toNamed<dynamic>(Routes.manageBusiness, arguments: true);
    if (result == true) {
      _fetchProfile();
    }
  }

  Future<void> onTapSelfAssessmentQuestion() async {
    final dynamic result =
        await Get.toNamed<dynamic>(Routes.selfAssessmentQuestion);
    if (result != null && result is SAQResult) {
      if (result.isSuccess) {
        _fetchStatus();
        SnackBars.complete(message: result.message).show(duration: 5000);
      } else {
        SnackBars.error(message: result.message).show(duration: 5000);
      }
    }
  }

  Future<void> _fetchStatus({bool isDisplayLoading = false}) async {
    ProcessingDialog processingDialog = ProcessingDialog();
    if (isDisplayLoading) {
      processingDialog.show();
    }
    await _fetchProfile();
    await _loadSAQQuestions();

    processingDialog.hide();
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

  Future<void> _loadSAQQuestions() async {
    if (!hasRequiredSAQ) return;
    final saqResult = await _saqHttpService.getSelfAssessments();
    if (saqResult.isSuccess() && saqResult.data != null) {
      await _saqCacheService.saveSAQLatestData(
        profile.id,
        saqResult.response!.data! as Map<String, dynamic>,
      );
      _saqData = saqResult.data;
    } else {
      String languageCode =
          Prefs.getString(Defines.languageKey, defaultValue: 'en');
      _saqData = _saqCacheService.getSAQLatestInStorage(
        profile.id,
        languageCode,
      );
    }
    //update status
    if (profile.answeredSaqAt != null) {
      saqStatus = SAQStatusEnum.completed;
    } else if (_saqData?.selfAssessment?.isDraft == true) {
      saqStatus = SAQStatusEnum.draft;
    } else {
      saqStatus = SAQStatusEnum.none;
    }
  }
}
