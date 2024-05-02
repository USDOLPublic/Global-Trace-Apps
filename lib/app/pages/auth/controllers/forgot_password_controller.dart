import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class ForgotPasswordController extends AuthController {
  final forgotFormGlobalKey = GlobalKey<FormState>();
  late final AuthHttpService _authHttpService;

  final _isRequested = false.obs;
  bool get isRequested => _isRequested.value;
  set isRequested(bool value) => _isRequested.value = value;

  final _enableSignInBtn = false.obs;
  bool get enableSignInBtn => _enableSignInBtn.value;
  set enableSignInBtn(bool value) => _enableSignInBtn.value = value;

  TextEditingController accountFieldController = TextEditingController();
  String get account => accountFieldController.text.trim();
  FocusNode emailNode = FocusNode();

  bool get isFormValided {
    return forgotFormGlobalKey.currentState?.validate() ?? false;
  }

  @override
  void onInit() {
    _authHttpService = Get.find<AuthHttpService>();
    emailNode.addListener(() {
      accountFieldController.text = accountFieldController.text.trim();
    });
    super.onInit();
  }

  void checkFormValidation() {
    if (enableSignInBtn && !isFormValided) {
      enableSignInBtn = false;
    } else if (!enableSignInBtn && isFormValided) {
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

  Future<bool> sendRequestResetPassword() async {
    if (isFormValided) {
      ProcessingDialog processingDialog = ProcessingDialog.show();
      final res = await _authHttpService.resetPassword(account);
      if (res.isSuccess()) {
        processingDialog.hide();
        isRequested = true;
        return true;
      } else {
        processingDialog.hide();
        SnackBars.error(message: S.current.thisEmailDoesNotExist).show();
        return false;
      }
    }
    return false;
  }
}
