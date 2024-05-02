import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class PartnerContactInputView extends StatelessWidget {
  const PartnerContactInputView({
    super.key,
    required this.formId,
    required this.partnerTitle,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.isEnableEdit,
  });

  final String formId;
  final String partnerTitle;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final bool isEnableEdit;

  @override
  Widget build(BuildContext context) {
    return _buildContact(context);
  }

  Widget _buildContact(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          partnerTitle,
          style: AppTextStyles.title(),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFieldInput(
          key: ValueKey("$formId-firstNameInput"),
          labelText: S.of(context).firstName,
          inputController: firstNameController,
          validator: Validator.firstNameValidation,
          tagId: '$formId-firstName',
          enabled: isEnableEdit,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFieldInput(
          key: ValueKey("$formId-lastNameInput"),
          labelText: S.of(context).lastName,
          inputController: lastNameController,
          validator: Validator.lastNameValidation,
          tagId: '$formId-lastName',
          enabled: isEnableEdit,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFieldInput(
          key: ValueKey("$formId-emailInput"),
          labelText: S.of(context).email,
          inputController: emailController,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
            LowerCaseTextFormatter(),
          ],
          validator: Validator.emailValidation,
          tagId: '$formId-email',
          enabled: isEnableEdit,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFieldInput(
          key: ValueKey("$formId-phoneInput"),
          labelText: S.of(context).phoneInput,
          inputController: phoneController,
          tagId: '$formId-phone',
          enabled: isEnableEdit,
          label: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: S.of(context).showPhone),
                TextSpan(
                  text: S.of(context).optional,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
