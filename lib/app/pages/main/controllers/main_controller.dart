import 'dart:async';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import '../../../core.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  late final SessionManager _sessionM;
  late final UserCacheService _userCacheS;

  final _userInfo = UserModel(id: "").obs;
  UserModel get userInfo => _userInfo.value;
  set userInfo(UserModel value) => _userInfo.value = value;

  bool get isProductUser => userInfo.isProductUser();
  bool get isLaborUser => userInfo.isLaborUser();

  StreamSubscription? _subUserInfo;
  StreamSubscription? _dynamicLinkHandle;

  @override
  void onInit() {
    appInitializer();
    super.onInit();
  }

  @override
  void onClose() async {
    await _subUserInfo?.cancel();
    await _dynamicLinkHandle?.cancel();
    await HiveManager.close();
    super.onClose();
  }

  Future<void> appInitializer() async {
    await Prefs.load();
    _sessionM = Get.find<SessionManager>();
    _userCacheS = Get.find<UserCacheService>();

    //Init Hive
    await HiveManager.init();

    await _userCacheS.init();
    await LocationImportHelper().init();
    await StaticResourceHelper().init();
    await LocationImportHelper().importData();

    DioHelper.updateBaseUrl(
      DioHelper.currentDio(),
      Uri.parse(BuildConfig().env.baseApi),
    );
    //Set Language
    String lang = Prefs.getString(Defines.languageKey, defaultValue: "en");
    DioHelper.updateHeader(
      DioHelper.currentDio(),
      {
        "language": lang,
      },
    );
    DioHelper.setInterceptorRetry(
      DioHelper.currentDio(),
      retries: 1,
      retryEvaluator: DefaultRetryEvaluator(const {
        status408RequestTimeout,
        status429TooManyRequests,
        status504GatewayTimeout,
        status440LoginTimeout,
        status499ClientClosedRequest,
        status460ClientClosedRequest,
        status522ConnectionTimedOut,
        status524TimeoutOccurred,
        status500InternalServerError,
        status503ServiceUnavailable,
        status403Forbidden,
      }),
    );
    await MyApp.of(Get.context!)?.setLanguage(lang, 'US');

    bool isAuthenticated = await _isAuthenticated();
    _subUserInfo =
        _userCacheS.userRepo.dataStream.listen((Map<String, UserModel> event) {
      UserModel? currentUserInfo = event[_sessionM.session?.userId];
      if (currentUserInfo != null) {
        userInfo = currentUserInfo;
      }
    });
    await initDynamicLinks();
    if (isAuthenticated) {
      await _fetchProfileData();
      redirectAccessToApp();
    } else {
      Get.offNamed<void>(Routes.login);
    }
  }

  Future<void> redirectAccessToApp({bool isFromLogin = false}) async {
    ProcessingDialog processingDialog = ProcessingDialog();
    if (isFromLogin) {
      processingDialog.show();
      await StaticResourceHelper().fetchStaticResource(
        userInfo.isProductUser(),
      );
    } else {
      StaticResourceHelper().fetchStaticResource(
        userInfo.isProductUser(),
      );
    }
    final completedOnBoard = await MainController.to.checkCompletedTask();
    processingDialog.hide();
    if (userInfo.hasPermission(PermissionActionDef.invitePartners)) {
      _cacheManagePartner();
    }
    if (userInfo.isAdministrator()) {
      Get.offNamed<void>(Routes.homeLabor);
    } else if (!completedOnBoard) {
      await _goToOnboard();
    } else {
      if (userInfo.isProductUser()) {
        Get.offNamed<void>(Routes.homeProduct);
      } else {
        Get.offNamed<void>(Routes.homeLabor);
      }
    }
  }

  Future<void> _goToOnboard() async {
    Get.offNamed<void>(Routes.onboard);
  }

  Future<void> initDynamicLinks() async {
    _dynamicLinkHandle = FlutterBranchSdk.listSession().listen(
      (data) async {
        if (data.containsKey('+clicked_branch_link') &&
            data['+clicked_branch_link'] == true) {
          String url = data[r'$fallback_url'].toString().trim();
          Uri? uri = Uri.tryParse(url);
          if (uri != null) {
            _handleDynamicLink(uri);
          }
        }
      },
    );
  }

  Future<void> _handleResetPassword(String resetToken) async {
    await _sessionM.cleanSession();
    if (Get.isRegistered<ResetPasswordController>()) {
      Get.find<ResetPasswordController>().updateResetToken(resetToken);
    }
    if (Get.currentRoute != Routes.resetPassword) {
      Get.offAllNamed<void>(Routes.resetPassword, arguments: resetToken);
    }
  }

  Future<void> _handleSignUp(String inviteToken) async {
    await _sessionM.cleanSession();
    if (Get.isRegistered<RegisterController>()) {
      Get.find<RegisterController>().updateInviteToken(inviteToken);
    }
    if (Get.currentRoute != Routes.register) {
      Get.offAllNamed<void>(Routes.register, arguments: inviteToken);
    }
  }

  void _handleDynamicLink(Uri url) async {
    List<String> separatedString = [];
    separatedString.addAll(url.path.split('/'));
    url.queryParameters.forEach((k, v) {
      LogUtil.d('[DynamicLinks] key: $k - value: $v');
    });

    if (separatedString[1] == "sign-up") {
      final String inviteToken = url.queryParameters["invite-token"] ?? "";
      await _handleSignUp(inviteToken);
    } else if (separatedString[1] == "reset-password") {
      final String resetToken = url.queryParameters["token"] ?? "";
      await _handleResetPassword(resetToken);
    }
  }

  Future<bool> _isAuthenticated() async {
    if (_sessionM.hasSession()) {
      await _sessionM.initSession(_sessionM.session!);
      return true;
    } else {
      return false;
    }
  }

  Future<void> _cacheManagePartner() async {
    final ManagePartnerCacheService _cacheService = ManagePartnerCacheService();
    final InvitePartnerService _service = InvitePartnerService();

    await _cacheService.init();

    final resp = await _service.getBusinessPartners();
    if (resp.isSuccess() && resp.data != null) {
      Map<String, FacilityRespModel> mapData = <String, FacilityRespModel>{};
      for (var e in resp.data!) {
        mapData[e.id ?? ''] = e;
      }
      if (mapData.isNotEmpty) {
        _cacheService.repository.assignAll(mapData);
      }
    }
  }

  Future<void> _fetchProfileData() async {
    final ProfileHttpService _service = ProfileHttpService();
    final profileRes = await _service.loadProfile();
    if (profileRes.isSuccess() && profileRes.data != null) {
      UserModel profile = profileRes.data!;
      await _userCacheS.userRepo.put(profile.id, profile);
    }
  }

  Future<bool> checkCompletedTask() async {
    bool isPassedProfile = true;
    bool isPassedPartnerManager = true;
    bool isPassedSAQ = true;
    if (userInfo.hasPermission(PermissionActionDef.completeOwnProfile)) {
      isPassedProfile = (userInfo.updatedProfileAt ?? 0) != 0;
    }
    if (userInfo.hasPermission(PermissionActionDef.invitePartners)) {
      isPassedPartnerManager = (userInfo.addedPartnerAt ?? 0) != 0;
    }
    if (userInfo.hasPermission(PermissionActionDef.completeOwnSaq)) {
      isPassedSAQ = (userInfo.answeredSaqAt ?? 0) != 0;
    }
    return isPassedProfile && isPassedPartnerManager && isPassedSAQ;
  }

  Future<void> signOut() async {
    ProcessingDialog processing = ProcessingDialog.show();
    await _sessionM.cleanSession();
    processing.hide();
    Get.offNamed<void>(Routes.login);
  }
}
