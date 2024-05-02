import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({Key? key}) : super(key: key);

  Future _onTapButtonSave() async {
    var result = await controller.onTapButtonSave();
    if (result) {
      Get.back<bool>(result: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleFieldTextStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.green800,
      fontSize: 12,
    );
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).resetPassword,
        hasCloseButton: true,
        hasBackButton: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            onChanged: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    S.of(context).currentPasswordLower,
                    style: titleFieldTextStyle,
                  ),
                ),
                Obx(
                  () => TextFieldInput(
                    key: const ValueKey('currentPassword'),
                    inputController: controller.currentPasswordController,
                    obscureText: controller.currentPasswordShow,
                    autoTrimValidator: false,
                    suffixIcon: TextButton(
                      onPressed: () {
                        controller.currentPasswordShow =
                            !controller.currentPasswordShow;
                      },
                      child: Obx(
                        () => Icon(
                          controller.currentPasswordShow
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.grey300,
                          size: 20,
                        ),
                      ),
                    ),
                    tagId: "currentPassword",
                    onChanged: (_) => controller.checkFormValidation(),
                    onFieldSubmitted: (_) {
                      controller.newPasswordNode.requestFocus();
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                  () => TextFieldInput(
                    key: const ValueKey('newPasswordInput'),
                    inputController: controller.newPasswordController,
                    validator: (text) => controller.newPasswordValidation(
                      text,
                      controller.currentPasswordController.text,
                    ),
                    obscureText: controller.newPasswordShow,
                    autoTrimValidator: false,
                    suffixIcon: TextButton(
                      onPressed: () {
                        controller.newPasswordShow =
                            !controller.newPasswordShow;
                      },
                      child: Icon(
                        controller.newPasswordShow
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.grey300,
                        size: 20,
                      ),
                    ),
                    tagId: "newPassword",
                    onChanged: (_) => controller.checkFormValidation(),
                    focusNode: controller.newPasswordNode,
                    onFieldSubmitted: (_) {
                      controller.confirmPasswordNode.requestFocus();
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    S.of(context).confirmPasswordLower,
                    style: titleFieldTextStyle,
                  ),
                ),
                Obx(
                  () => TextFieldInput(
                    key: const ValueKey('confirmPasswordInput'),
                    inputController: controller.confirmPasswordController,
                    validator: (text) => controller.confirmPasswordValidation(
                      text,
                      controller.newPasswordController.text,
                    ),
                    obscureText: controller.confirmPasswordShow,
                    autoTrimValidator: false,
                    suffixIcon: TextButton(
                      onPressed: () {
                        controller.confirmPasswordShow =
                            !controller.confirmPasswordShow;
                      },
                      child: Obx(
                        () => Icon(
                          controller.confirmPasswordShow
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.grey300,
                          size: 20,
                        ),
                      ),
                    ),
                    tagId: "confirmPassword",
                    onChanged: (_) => controller.checkFormValidation(),
                    textInputAction: TextInputAction.done,
                    focusNode: controller.confirmPasswordNode,
                    onFieldSubmitted: (_) {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        _onTapButtonSave();
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppProperties.contentMargin),
                  child: SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () {
                        bool isEnableBtn = controller.enableButtonSave;
                        ButtonStyle nextBtnStyle = ElevatedBtnStyle.disable();
                        if (isEnableBtn) {
                          nextBtnStyle = ElevatedBtnStyle.enable();
                        }
                        return ElevatedButton(
                          onPressed: _onTapButtonSave,
                          style: nextBtnStyle,
                          child: Text(
                            S.of(context).save,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
