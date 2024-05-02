import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class DropdownInputWidget extends GetView<DropdownInputController> {
  const DropdownInputWidget({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  String? get tag => id;

  void _onChanged(InputItem? item) {
    if (item != null) {
      controller.itemSelected = item;
    } else {
      controller.itemSelected = InputItem.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownInput(
        key: ValueKey('dropdown-input-$id'),
        itemList: controller.options,
        selected: controller.itemSelected,
        label: controller.getTitle(),
        hint: controller.getTitle(),
        onChanged: _onChanged,
        verticalMargin: 0,
      ),
    );
  }
}
