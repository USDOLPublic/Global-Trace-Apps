import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usdol/app/core.dart';
import 'widgets/edit_labor_profile.dart';
import 'widgets/edit_product_profile.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  void _nextButtonOnClicked() {
    controller.onTapButtonNext();
  }

  void _onLocationChange() {
    controller.checkFormValidation();
  }

  void _onEmailChange(String text) {
    if (text.trim().isEmpty) {
      controller.emailController.clear();
    }
  }

  Future<void> _onTapEditPassword() async {
    final dynamic result = await Get.toNamed<dynamic>(Routes.editPassword);
    if (result != null && result is bool && result) {
      SnackBars.complete(message: S.current.yourPasswordHasUpdated)
          .show(duration: 5000);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLaborUser = controller.userInfo.isLaborUser();
    return Scaffold(
      appBar: AppAppBar(title: controller.pageTitle),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        key: const ValueKey("editProfileScroll"),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            onChanged: () => controller.checkFormValidation(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).contact,
                  style: AppTextStyles.title(),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFieldInput(
                        key: const ValueKey('firstNameInput'),
                        labelText: S.of(context).firstName,
                        inputController: controller.firstNameController,
                        validator: Validator.firstNameValidation,
                        tagId: "firstName",
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFieldInput(
                        key: const ValueKey('lastNameInput'),
                        labelText: S.of(context).lastName,
                        inputController: controller.lastNameController,
                        validator: Validator.lastNameValidation,
                        tagId: "lastName",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldInput(
                  key: const ValueKey('phoneInput'),
                  labelText: S.of(context).showPhone,
                  inputController: controller.phoneController,
                  tagId: "phone",
                  label: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: S.of(context).showPhone),
                        TextSpan(
                            text: S.of(context).optional,
                            style:
                                const TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldInput(
                  key: const ValueKey('emailInput'),
                  labelText: S.of(context).email,
                  inputController: controller.emailController,
                  validator: Validator.emailValidation,
                  focusNode: controller.emailNode,
                  onChanged: _onEmailChange,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
                    LowerCaseTextFormatter(),
                  ],
                  tagId: "email",
                  onFieldSubmitted: (_) {
                    if (isLaborUser) {
                      controller.addressNode.requestFocus();
                    } else {
                      controller.nameNode.requestFocus();
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                if (controller.type != EditProfileType.fromOnboard)
                  Stack(
                    children: [
                      TextFieldInput(
                        key: const ValueKey('passwordInput'),
                        labelText: S.of(context).currentPassword,
                        inputController: controller.currentPasswordController,
                        enabled: false,
                        tagId: "password",
                      ),
                      Positioned(
                        top: 6,
                        right: 2,
                        child: IconButton(
                          onPressed: _onTapEditPassword,
                          splashRadius: 2,
                          icon: SvgPicture.asset(
                            AssetsConst.iconEdit,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 24,
                ),
                isLaborUser
                    ? EditLaborProfile(
                        onLocationChanged: _onLocationChange,
                        onNext: _nextButtonOnClicked,
                      )
                    : EditProductProfile(
                        onLocationChanged: _onLocationChange,
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAction(
        childContent: Obx(
          () {
            bool enable = controller.enableNextButton;
            ButtonStyle btnStyle = ElevatedBtnStyle.disable();
            if (enable) {
              btnStyle = ElevatedBtnStyle.enable();
            }
            return ElevatedButton(
              key: const ValueKey("nextButton"),
              style: btnStyle,
              onPressed: _nextButtonOnClicked,
              child: Text((controller.type == EditProfileType.fromProfile ||
                      isLaborUser)
                  ? S.of(context).save
                  : S.of(context).next),
            );
          },
        ),
      ),
    );
  }
}
