import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

enum RestPasswordState {
  creating,
  successfull,
  invalid,
}

class ResetPasswordController extends AuthController {
  late final AuthHttpService _authHttpService;
  late String _resetToken;

  final _resetState = RestPasswordState.creating.obs;
  RestPasswordState get resetState => _resetState.value;
  set resetState(RestPasswordState value) => _resetState.value = value;

  final _enableSignUpBtn = false.obs;
  bool get enableSignUpBtn => _enableSignUpBtn.value;
  set enableSignUpBtn(bool value) => _enableSignUpBtn.value = value;

  final _isShowPassword = false.obs;
  bool get isShowPassword => _isShowPassword.value;
  set isShowPassword(bool value) => _isShowPassword.value = value;

  final _isShowConfirmPassword = false.obs;
  bool get isShowConfirmPassword => _isShowConfirmPassword.value;
  set isShowConfirmPassword(bool value) => _isShowConfirmPassword.value = value;

  final resetPassFormGlobalKey = GlobalKey<FormState>();

  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController confirmPasswordFieldController = TextEditingController();

  String get password => passwordFieldController.text.trim();
  String get confirmPassword => confirmPasswordFieldController.text.trim();
  bool get isFormValided {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return false;
    } else {
      return resetPassFormGlobalKey.currentState?.validate() ?? false;
    }
  }

  @override
  void onInit() {
    _authHttpService = Get.find<AuthHttpService>();
    if (Get.arguments != null && Get.arguments is String) {
      _resetToken = Get.arguments.toString();
      LogUtil.d("ResetPassword Reset token: $_resetToken");
    }
    super.onInit();
  }

  void updateResetToken(String token) {
    _resetToken = token;
    resetState = RestPasswordState.creating;
    passwordFieldController.text = "";
    confirmPasswordFieldController.text = "";
    resetPassFormGlobalKey.currentState?.reset();
    LogUtil.d("ResetPassword Update Reset Token $token");
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

  Future<bool> _validateResetToken(String resetToken) async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final res = await _authHttpService.resetPasswordCheckToken(resetToken);
    processingDialog.hide();
    if (res.isSuccess()) {
      return true;
    }
    resetState = RestPasswordState.invalid;
    SnackBars.error(message: res.getErrorMessage()).show();
    return false;
  }

  Future<bool> resetPassword() async {
    if (isFormValided) {
      bool isValid = await _validateResetToken(_resetToken);
      if (isValid) {
        ProcessingDialog processingDialog = ProcessingDialog.show();
        final res = await _authHttpService.updatePassword(_resetToken, password);
        processingDialog.hide();
        if (res.isSuccess()) {
          resetState = RestPasswordState.successfull;
          return true;
        } else {
          //
          SnackBars.error(message: res.getErrorMessage()).show();
        }
      }
    }
    return false;
  }
}
