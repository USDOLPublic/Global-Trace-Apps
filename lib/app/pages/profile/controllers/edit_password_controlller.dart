import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class EditPasswordController extends GetxController {
  late GlobalKey<FormState> formKey;

  final _currentPasswordShow = true.obs;
  bool get currentPasswordShow => _currentPasswordShow.value;
  set currentPasswordShow(bool value) => _currentPasswordShow.value = value;

  final _newPasswordShow = true.obs;
  bool get newPasswordShow => _newPasswordShow.value;
  set newPasswordShow(bool value) => _newPasswordShow.value = value;

  final _confirmPasswordShow = true.obs;
  bool get confirmPasswordShow => _confirmPasswordShow.value;
  set confirmPasswordShow(bool value) => _confirmPasswordShow.value = value;

  final _enableButtonSave = false.obs;
  bool get enableButtonSave => _enableButtonSave.value;
  set enableButtonSave(bool value) => _enableButtonSave.value = value;

  late final ProfileHttpService _profileHttpService;

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode newPasswordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  String? newPasswordValidation(String? value, String? oldPassword) {
    if (value == null || value.length < 8) {
      return S.current.invalidPasswordLength;
    } else if (!StringExtensions(value).isLeastOneLetter()) {
      return S.current.invalidPasswordOneLetter;
    } else if (!StringExtensions(value).isLeastOneCapitalLetter()) {
      return S.current.invalidPasswordOneCapitalLetter;
    } else if (!StringExtensions(value).isLeastOneNumber()) {
      return S.current.invalidPasswordOneNumber;
    } else if (!StringExtensions(value).isPasswordCustom()) {
      return S.current.invalidPassword;
    } else if (value == oldPassword) {
      return S.current.newPasswordMustBeDifferent;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidation(String? value, String? newPassword) {
    if (value != newPassword) {
      return S.current.confirmPasswordNotMatch;
    } else {
      return null;
    }
  }

  bool get isFormValidate {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      return false;
    } else {
      return formKey.currentState?.validate() ?? false;
    }
  }

  void checkFormValidation() {
    if (enableButtonSave && !isFormValidate) {
      enableButtonSave = false;
    } else if (!enableButtonSave && isFormValidate) {
      enableButtonSave = true;
    }
  }

  Future<bool> onTapButtonSave() async {
    if (enableButtonSave) {
      final resp = await _profileHttpService.updatePassword(
        currentPasswordController.text.trim(),
        newPasswordController.text.trim(),
      );

      if (!resp.isSuccess()) {
        String errorMessage = resp.getErrorMessage();
        SnackBars.error(message: errorMessage).show(duration: 5000);
      }

      return resp.isSuccess();
    }

    return false;
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    _profileHttpService = Get.find<ProfileHttpService>();
    super.onInit();
  }
}
