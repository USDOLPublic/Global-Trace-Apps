import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  void _forgotPasswordOnClicked() {
    controller.sendRequestResetPassword();
  }

  void _loginOnClicked() {
    Get.offNamed<void>(Routes.login);
  }

  void _formOnChange() {
    controller.checkFormValidation();
  }

  void _onEmailChange(String text) {
    if (text.trim().isEmpty) {
      controller.accountFieldController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isRequested) {
          return AuthLayout(
            title: S.of(context).checkYourEmail,
            icon: SvgPicture.asset(AssetsConst.svgEmailRead),
            subtitle: S.of(context).weSentYouAPassword,
            child: _buildRequestedResetPassword(context),
            authController: controller,
          );
        } else {
          return AuthLayout(
            title: S.of(context).forgotPasswordTitle,
            subtitle: S.of(context).enterYourEmailBelow,
            child: _buildForgotView(context),
            authController: controller,
          );
        }
      }),
    );
  }

  Widget _buildForgotView(BuildContext context) {
    TextStyle titleFieldTextStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.green800,
      fontSize: 12,
    );
    return Form(
      key: controller.forgotFormGlobalKey,
      onChanged: _formOnChange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              S.of(context).email,
              style: titleFieldTextStyle,
            ),
          ),
          TextFormField(
            maxLines: 1,
            controller: controller.accountFieldController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
              LowerCaseTextFormatter(),
            ],
            focusNode: controller.emailNode,
            onChanged: _onEmailChange,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: S.of(context).yourEmail,
              errorMaxLines: 3,
            ),
            validator: controller.accountValidation,
            onFieldSubmitted: (_) {
              if (controller.forgotFormGlobalKey.currentState?.validate() ?? false) {
                _forgotPasswordOnClicked();
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
                  style: btnStyle,
                  onPressed: _forgotPasswordOnClicked,
                  child: Text(S.of(context).send),
                );
              }),
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: Text.rich(
              TextSpan(
                text: S.of(context).rememberYourPassword,
                style: const TextStyle(
                  color: AppColors.grey300,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: S.of(context).logIn,
                    style: const TextStyle(
                      color: AppColors.green800,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _loginOnClicked,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestedResetPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _loginOnClicked,
          child: Text(S.of(context).backToLogin),
        ),
      ),
    );
  }
}
