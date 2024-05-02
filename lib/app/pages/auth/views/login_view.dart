import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  void _formOnChange() {
    controller.checkFormValidation();
  }

  void _signInOnClicked() async {
    if (controller.isFormValid) {
      final result = await controller.signIn(
        userName: controller.account,
        pass: controller.password,
      );
      //handel login result
      if (result) {
        await controller.redirectAccessToApp();
      } else {
        controller.accountNode.requestFocus();
      }
    }
  }

  void _forgotPasswordOnClicked() {
    Get.offNamed<void>(Routes.forgotPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayout(
        title: S.of(context).signIn,
        child: _buildLoginView(context),
        authController: controller,
      ),
    );
  }

  Widget _buildLoginView(BuildContext context) {
    TextStyle titleFieldTextStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.green800,
      fontSize: 12,
    );
    return Form(
      key: controller.loginFormGlobalKey,
      onChanged: _formOnChange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              S.of(context).account,
              style: titleFieldTextStyle,
            ),
          ),
          TextFormField(
            key: const ValueKey('emailSignUpField'),
            maxLines: 1,
            textInputAction: TextInputAction.next,
            controller: controller.accountFieldController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
              LowerCaseTextFormatter(),
            ],
            focusNode: controller.accountNode,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              errorMaxLines: 3,
            ),
            validator: (text) {
              return controller.accountValidation(text?.trim());
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              S.of(context).password,
              style: titleFieldTextStyle,
            ),
          ),
          TextFormField(
            key: const ValueKey('passwordSignUpField'),
            maxLines: 1,
            obscureText: true,
            controller: controller.passwordFieldController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              errorMaxLines: 3,
            ),
            onFieldSubmitted: (_) {
              if (controller.loginFormGlobalKey.currentState?.validate() ??
                  false) {
                _signInOnClicked();
              }
            },
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: SizedBox(
              width: double.infinity,
              child: Obx(() {
                bool enable = controller.enableSignInBtn;
                ButtonStyle btnStyle = ElevatedBtnStyle.disable();
                if (enable) {
                  btnStyle = ElevatedBtnStyle.enable();
                }
                return ElevatedButton(
                  key: const ValueKey('signInButton'),
                  style: btnStyle,
                  onPressed: _signInOnClicked,
                  child: Text(S.of(context).signIn),
                );
              }),
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: Text.rich(
              TextSpan(
                  text: S.of(context).forgotPassword,
                  style: const TextStyle(
                    color: AppColors.grey600,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _forgotPasswordOnClicked),
            ),
          ),
        ],
      ),
    );
  }
}
