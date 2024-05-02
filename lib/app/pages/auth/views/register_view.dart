import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  void _formOnChange() {
    controller.checkFormValidation();
  }

  void _loginOnClicked() {
    Get.offNamed<void>(Routes.login);
  }

  void _signUpOnClicked() async {
    final result = await controller.signUp();
    if (result) {
      Get.offNamed<void>(Routes.onboard);
    }
  }

  void _showPasswordOnClicked() {
    controller.isShowPassword = !controller.isShowPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.enableRedirectLoginPage) {
          return AuthLayout(
            icon: Icon(
              Icons.check_circle_sharp,
              size: 66,
              color: Theme.of(context).primaryColor,
            ),
            title: S.of(context).finishCreatingAccount,
            subtitle: S.of(context).yourAccountSuccessfullyCreated,
            child: _buildFinishCreatingAccountView(context),
            authController: controller,
          );
        } else {
          return AuthLayout(
            title: S.of(context).welcome,
            subtitle: S.of(context).makeAnAccountHere,
            child: _buildRegisterView(context),
            authController: controller,
          );
        }
      }),
    );
  }

  Widget _buildRegisterView(BuildContext context) {
    TextStyle titleFieldTextStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.green800,
      fontSize: 12,
    );
    return Form(
      key: controller.registerFormGlobalKey,
      onChanged: _formOnChange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Text(
                  S.of(context).password,
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
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(emojisUnicodes))
              ],
              decoration: InputDecoration(
                errorMaxLines: 3,
                suffixIcon: IconButton(
                  onPressed: _showPasswordOnClicked,
                  icon: Icon(controller.isShowPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
              ),
              validator: controller.passwordValidation,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              S.of(context).confirmPassword,
              style: titleFieldTextStyle,
            ),
          ),
          TextFormField(
            maxLines: 1,
            obscureText: true,
            controller: controller.confirmPasswordFieldController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(emojisUnicodes))
            ],
            decoration: const InputDecoration(
              errorMaxLines: 3,
            ),
            validator: controller.confirmPasswordValidation,
            onFieldSubmitted: (_) {
              if (controller.registerFormGlobalKey.currentState?.validate() ??
                  false) {
                _signUpOnClicked();
              }
            },
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
                  onPressed: _signUpOnClicked,
                  child: Text(S.of(context).signUp),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishCreatingAccountView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _loginOnClicked,
          child: Text(S.of(context).logIn),
        ),
      ),
    );
  }
}
