import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class NumberInputWidget extends GetView<NumberInputController> {
  const NumberInputWidget({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      key: ValueKey('number-input$id'),
      labelText: controller.getTitle(),
      textInputAction: TextInputAction.done,
      inputController: controller.inputTextController,
      focusNode: controller.inputNode,
      tagId: 'number-input$id',
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(decimalRegPattern)),
        DecimalTextFormatter(allowFraction: true),
      ],
      validator: controller.inputValidation,
      onChanged: controller.inputOnChanged,
    );
  }
}
