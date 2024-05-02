import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeSelectorController extends GetxController with GetSingleTickerProviderStateMixin {
  final bool isOnlyDate;
  late TabController tabController;
  final _dateTimeSelected = DateTime.now().obs;

  DateTimeSelectorController({
    this.isOnlyDate = false,
  });

  DateTime get dateTimeSelected => _dateTimeSelected.value;

  set dateTimeSelected(DateTime value) => _dateTimeSelected.value = value;

  @override
  void onInit() {
    tabController = TabController(initialIndex: 0, length: isOnlyDate ? 1 : 2, vsync: this);
    super.onInit();
  }

  void onSelectDate(DateTime time) {
    _dateTimeSelected.value = DateTime(
      time.year,
      time.month,
      time.day,
      dateTimeSelected.hour,
      dateTimeSelected.minute,
      dateTimeSelected.second,
      dateTimeSelected.millisecond,
      dateTimeSelected.microsecond,
    );
  }

  void onSelectTime(DateTime time) {
    _dateTimeSelected.value = DateTime(
      dateTimeSelected.year,
      dateTimeSelected.month,
      dateTimeSelected.day,
      time.hour,
      time.minute,
      time.second,
      time.millisecond,
      time.microsecond,
    );
  }
}
