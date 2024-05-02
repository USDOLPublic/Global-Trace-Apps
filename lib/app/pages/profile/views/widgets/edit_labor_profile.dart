import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class EditLaborProfile extends GetView<EditProfileController> {
  const EditLaborProfile({
    super.key,
    required this.onLocationChanged,
    required this.onNext,
  });

  final void Function() onLocationChanged;
  final void Function() onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).organizationDetail,
          style: AppTextStyles.title(),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFieldInput(
          key: const ValueKey('nameInput'),
          labelText: S.of(context).laborName,
          focusNode: controller.nameNode,
          inputController: controller.nameController,
          validator: Validator.nameValidation,
          tagId: "name",
        ),
        const SizedBox(
          height: 8,
        ),
        TextFieldInput(
          key: const ValueKey('businessRegisterNumber'),
          labelText: S.of(context).businessRegisterNumber,
          inputController: controller.registerNumberController,
          validator: Validator.businessValidation,
          tagId: "business",
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: LocationInputView(
              viewId: 'edit-labor-profile',
              locationController: controller.locationInputController,
              onChanged: onLocationChanged,
              isDisable: false,
            ),
          ),
        ),
        TextFieldInput(
          key: const ValueKey("streetAddressInput"),
          labelText: S.of(context).streetAddress,
          inputController: controller.addressController,
          focusNode: controller.addressNode,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            if (controller.formKey.currentState?.validate() ?? false) {
              onNext();
            }

            return null;
          },
          tagId: "street",
        ),
      ],
    );
  }
}
