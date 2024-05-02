import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class PercentageInputWidget extends GetView<PercentageInputController> {
  const PercentageInputWidget({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      key: ValueKey('percentage-input$id'),
      labelText: controller.getTitle(),
      textInputAction: TextInputAction.done,
      inputController: controller.inputTextController,
      focusNode: controller.inputNode,
      tagId: 'percentage-input$id',
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      inputFormatters: <TextInputFormatter>[
        PercentTextFormatter(allowFraction: true),
      ],
      onChanged: controller.inputOnChanged,
      validator: controller.inputValidation,
    );
  }
}
