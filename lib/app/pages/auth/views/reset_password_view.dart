import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  void _forgotPasswordOnClicked() {
    Get.offNamed<void>(Routes.forgotPassword);
  }

  void _formOnChange() {
    controller.checkFormValidation();
  }

  void _showPasswordOnClicked() {
    controller.isShowPassword = !controller.isShowPassword;
  }

  void _showConfirmPasswordOnClicked() {
    controller.isShowConfirmPassword = !controller.isShowConfirmPassword;
  }

  void _resetPasswordOnClicked() {
    controller.resetPassword();
  }

  void _loginOnClicked() {
    Get.offNamed<void>(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.resetState) {
          case RestPasswordState.creating:
            return AuthLayout(
              title: S.of(context).resetPassword,
              subtitle: S.of(context).createYourNewPassword,
              child: _buildResetPasswordView(context),
              authController: controller,
            );
          case RestPasswordState.successfull:
            return AuthLayout(
              icon: Icon(
                Icons.check_circle_sharp,
                size: 66,
                color: Theme.of(context).primaryColor,
              ),
              title: S.of(context).youAreAllSet,
              subtitle: S.of(context).yourPasswordResetLinkIsOnlyVadid,
              child: _buildResetPasswordCompletedView(context),
              authController: controller,
            );
          case RestPasswordState.invalid:
            return AuthLayout(
              title: S.of(context).yourLinkHasExpired,
              subtitle: S.of(context).yourPasswordResetLinkIsOnlyVadid,
              child: _buildResetPasswordExpired(context),
              authController: controller,
            );
        }
      }),
    );
  }

  Widget _buildResetPasswordExpired(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _forgotPasswordOnClicked,
          child: Text(S.of(context).resetPassword),
        ),
      ),
    );
  }

  Widget _buildResetPasswordView(BuildContext context) {
    TextStyle titleFieldTextStyle = const TextStyle(fontWeight: FontWeight.w600, color: AppColors.green800, fontSize: 12);
    return Form(
      key: controller.resetPassFormGlobalKey,
      onChanged: _formOnChange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Text(
                  S.of(context).newPasswordLower,
                  style: titleFieldTextStyle,
                ),
                const SizedBox(width: 8),
                const PasswordTooltip(),
              ],
            ),
          ),
          Obx(
            () => TextFormField(
              maxLines: 1,
              obscureText: !controller.isShowPassword,
              controller: controller.passwordFieldController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                errorMaxLines: 3,
                suffixIcon: IconButton(
                  onPressed: _showPasswordOnClicked,
                  icon: Icon(controller.isShowPassword ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              validator: controller.passwordValidation,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              S.of(context).confirmPasswordLower,
              style: titleFieldTextStyle,
            ),
          ),
          Obx(
            () => TextFormField(
              maxLines: 1,
              obscureText: !controller.isShowConfirmPassword,
              controller: controller.confirmPasswordFieldController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.done,
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(emojisUnicodes))],
              decoration: InputDecoration(
                errorMaxLines: 3,
                suffixIcon: IconButton(
                  onPressed: _showConfirmPasswordOnClicked,
                  icon: Icon(controller.isShowConfirmPassword ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              validator: controller.confirmPasswordValidation,
              onFieldSubmitted: (_) {
                if (controller.resetPassFormGlobalKey.currentState?.validate() ?? false) {
                  _resetPasswordOnClicked();
                }
              },
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: SizedBox(
              width: double.infinity,
              child: Obx(() {
                bool enable = controller.enableSignUpBtn;
                ButtonStyle btnStyle = ElevatedBtnStyle.disable();
                if (enable) {
                  btnStyle = ElevatedBtnStyle.enable();
                }
                return ElevatedButton(
                  style: btnStyle,
                  onPressed: _resetPasswordOnClicked,
                  child: Text(S.of(context).resetPassword),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetPasswordCompletedView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedBtnStyle.enable(),
          onPressed: _loginOnClicked,
          child: Text(S.of(context).logIn),
        ),
      ),
    );
  }
}
