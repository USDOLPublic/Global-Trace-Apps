import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class DateInputWidget extends GetView<DateInputController> {
  const DateInputWidget({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  String? get tag => id;

  void _onChanged(DateTime? time) {
    if (time != null) {
      controller.datetimeSelected = time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DateTimeInput(
        key: const ValueKey('dateAndTime'),
        onChanged: _onChanged,
        selected: controller.datetimeSelected,
        label: controller.getTitle(),
        hint: controller.getTitle(),
        isAllowingGreaterThanToday: false,
      ),
    );
  }
}
