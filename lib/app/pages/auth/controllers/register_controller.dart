import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class RegisterController extends AuthController {
  late String _inviteToken;
  late final AuthHttpService _authHttpService;
  late final LoginController _loginController;

  final _enableSignUpBtn = false.obs;
  bool get enableSignUpBtn => _enableSignUpBtn.value;
  set enableSignUpBtn(bool value) => _enableSignUpBtn.value = value;

  final _enableRedirectLoginPage = false.obs;
  bool get enableRedirectLoginPage => _enableRedirectLoginPage.value;
  set enableRedirectLoginPage(bool value) => _enableRedirectLoginPage.value = value;

  final _isShowPassword = false.obs;
  bool get isShowPassword => _isShowPassword.value;
  set isShowPassword(bool value) => _isShowPassword.value = value;

  final registerFormGlobalKey = GlobalKey<FormState>();

  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController confirmPasswordFieldController = TextEditingController();

  String get password => passwordFieldController.text.trim();
  String get confirmPassword => confirmPasswordFieldController.text.trim();
  bool get isFormValided {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return false;
    } else {
      return registerFormGlobalKey.currentState?.validate() ?? false;
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is String) {
      _inviteToken = Get.arguments.toString();
      LogUtil.d("Register Invite token: $_inviteToken");
    }
    _authHttpService = Get.find<AuthHttpService>();
    _loginController = Get.find<LoginController>();
    super.onInit();
  }

  void updateInviteToken(String inviteToken) {
    _inviteToken = inviteToken;
    enableRedirectLoginPage = false;
    passwordFieldController.text = "";
    confirmPasswordFieldController.text = "";
    registerFormGlobalKey.currentState?.reset();
    LogUtil.d("Register Update Invite Token $_inviteToken");
  }

  void checkFormValidation() {
    if (enableSignUpBtn && !isFormValided) {
      enableSignUpBtn = false;
    } else if (!enableSignUpBtn && isFormValided) {
      enableSignUpBtn = true;
    }
  }

  String? passwordValidation(String? value) {
    if (value == null || value.length < 8) {
      return S.current.invalidPasswordLength;
    } else if (!StringExtensions(value).isLeastOneLetter()) {
      return S.current.invalidPasswordOneLetter;
    } else if (!StringExtensions(value).isLeastOneCapitalLetter()) {
      return S.current.invalidPasswordOneCapitalLetter;
    } else if (!StringExtensions(value).isLeastOneNumber()) {
      return S.current.invalidPasswordOneNumber;
    } else if (!StringExtensions(value).isLeastOneSpecial()) {
      return S.current.invalidPasswordOneSpecialLetter;
    } else if (!StringExtensions(value).isPasswordCustom()) {
      return S.current.invalidPassword;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidation(String? value) {
    if (value != null && password == confirmPassword) {
      return null;
    } else {
      return S.current.invalidConfirmPassword;
    }
  }

  Future<bool> signUp() async {
    if (isFormValided) {
      ProcessingDialog processingDialog = ProcessingDialog.show();
      final res = await _authHttpService.signUp(
        inviteToken: _inviteToken,
        password: password,
      );
      if (res.isSuccess() && res.data != null) {
        processingDialog.hide();
        RegisterResp registerInfo = res.data!;
        if (registerInfo.email != null && registerInfo.email!.isNotEmpty) {
          bool loginRes = await _loginController.signIn(
            userName: registerInfo.email!,
            pass: password,
          );
          enableRedirectLoginPage = !loginRes;
          return loginRes;
        } else {
          //account have not created
          SnackBars.error(message: S.current.genericErrorDescriptionShort).show();
          return false;
        }
      } else {
        processingDialog.hide();
        SnackBars.error(message: S.current.inviteTokenInvalid).show();
        return false;
      }
    }
    return false;
  }
}
