import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class TextInputWidget extends GetView<TextInputController> {
  const TextInputWidget({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  String? get tag => id;

  void _scanQRCodeOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.scanner,
      arguments: controller.getTitle(),
    );
    if (result != null && result is String) {
      controller.inputTextController.text = result;
      controller.inputOnChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      key: ValueKey('text-input-$id'),
      labelText: controller.getTitle(),
      textInputAction: TextInputAction.done,
      inputController: controller.inputTextController,
      focusNode: controller.inputNode,
      tagId: 'text-input-$id',
      keyboardType: TextInputType.text,
      validator: controller.inputValidation,
      onChanged: controller.inputOnChanged,
      inputFormatters: controller.isMaskFormatter
          ? [
              controller.idMaskInput,
            ]
          : null,
      suffixIcon: controller.isEnableQRCodeInput
          ? IconButton(
              onPressed: () => _scanQRCodeOnClicked(context),
              icon: SvgPicture.asset(
                AssetsConst.svgQrcode,
              ),
            )
          : null,
    );
  }
}
