import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class NumberUnitInputWidget extends GetView<NumberUnitInputController> {
  const NumberUnitInputWidget({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  String? get tag => id;

  void _onChangeUnit(InputItem? item) {
    if (item != null) {
      controller.itemSelected = item;
    } else {
      controller.itemSelected = InputItem.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RowInputWidget(
      firstInput: TextFieldInput(
        key: ValueKey('number-unit-value-$id'),
        labelText: controller.getTitle(),
        inputController: controller.inputTextController,
        tagId: 'number-unit-value-$id',
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(decimalRegPattern)),
          DecimalTextFormatter(allowFraction: true),
        ],
        validator: controller.inputValidation,
        onChanged: controller.inputOnChanged,
      ),
      secondInput: Obx(
        () => DropdownInput(
          key: ValueKey('number-unit-$id'),
          itemList: controller.options,
          selected: controller.itemSelected,
          label: S.of(context).unit,
          hint: S.of(context).unit,
          verticalMargin: 0,
          onChanged: _onChangeUnit,
        ),
      ),
      padding: EdgeInsets.zero,
    );
  }
}
