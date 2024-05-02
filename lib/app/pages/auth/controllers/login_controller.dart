import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class LoginController extends AuthController {
  late final AuthHttpService _authHttpService;
  late final ProfileHttpService _profileHttpService;
  late final SessionManager _sessionManager;
  late final UserCacheService _userCacheService;

  final _enableSignInBtn = false.obs;

  bool get enableSignInBtn => _enableSignInBtn.value;

  set enableSignInBtn(bool value) => _enableSignInBtn.value = value;

  final loginFormGlobalKey = GlobalKey<FormState>();

  TextEditingController accountFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  FocusNode accountNode = FocusNode();

  String get account => accountFieldController.text.trim();

  String get password => passwordFieldController.text.trim();

  bool get isFormValid {
    if (account.isEmpty || password.isEmpty) {
      return false;
    } else {
      return loginFormGlobalKey.currentState?.validate() ?? false;
    }
  }

  @override
  void onInit() {
    _authHttpService = Get.find<AuthHttpService>();
    _profileHttpService = Get.find<ProfileHttpService>();
    _sessionManager = Get.find<SessionManager>();
    _userCacheService = Get.find<UserCacheService>();
    accountNode.addListener(() {
      accountFieldController.text = accountFieldController.text.trim();
    });
    super.onInit();
  }

  void checkFormValidation() {
    if (enableSignInBtn && !isFormValid) {
      enableSignInBtn = false;
    } else if (!enableSignInBtn && isFormValid) {
      enableSignInBtn = true;
    }
  }

  String? accountValidation(String? value) {
    if (value != null && StringExtensions(value).isEmail()) {
      return null;
    } else {
      return S.current.invalidEmailAddress;
    }
  }

  SessionModel _createSession(LoginResp loginResp, UserModel? user) {
    SessionModel session = SessionModel(
      accessToken: loginResp.token ?? "",
      expireAt: loginResp.expireAt ?? 0,
      refreshToken: loginResp.refreshToken ?? "",
      userId: user?.id ?? "",
      email: user?.email ?? "",
      firstName: user?.firstName ?? "",
      lastName: user?.lastName ?? "",
    );
    return session;
  }

  bool _isUserValid(UserModel? user) {
    if (user != null) {
      return user.isMobileSupported();
    } else {
      return false;
    }
  }

  Future<bool> signIn({required String userName, required String pass}) async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final res =
        await _authHttpService.login(userName: userName, password: pass);
    if (res.isSuccess() && res.data != null) {
      LoginResp loginResp = res.data!;
      LogUtil.d("[Login]->" + loginResp.toString());
      UserModel? user = loginResp.user;
      bool isUserValid = _isUserValid(user);
      if (isUserValid) {
        await _sessionManager.initSession(_createSession(loginResp, user));
        final profileRes = await _profileHttpService.loadProfile();
        if (profileRes.isSuccess() && profileRes.data != null) {
          user = profileRes.data;
        }
        if (user != null) {
          await _userCacheService.userRepo.put(user.id, user);
        }
        processingDialog.hide();
      } else {
        processingDialog.hide();
        SnackBars.error(message: S.current.notSupportBusiness)
            .show(duration: 5000);
      }
      return isUserValid;
    } else {
      processingDialog.hide();
      SnackBars.error(message: S.current.erEmailOrPasswordInvalid).show();
      return false;
    }
  }

  Future<void> redirectAccessToApp() async {
    return MainController.to.redirectAccessToApp(isFromLogin: true);
  }
}
