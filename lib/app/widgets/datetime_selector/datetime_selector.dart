import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core.dart';
import 'datetime_selector_controller.dart';

class DateTimeSelector extends GetView<DateTimeSelectorController> {
  final DateTime? dateTimeInited;
  final DateTime? minDate;
  final DateTime? maxDate;
  final String formatDateTime;
  final bool isOnlyDate;
  final Function(DateTime?) onSelected;
  late final DatePickerDateOrder dateOrder;

  DateTimeSelector({
    Key? key,
    this.dateTimeInited,
    required this.onSelected,
    this.maxDate,
    this.minDate,
    this.isOnlyDate = false,
    this.formatDateTime = "yyyy/MM/dd",
  }) : super(key: key) {
    Get.put(DateTimeSelectorController(isOnlyDate: isOnlyDate));
    if (dateTimeInited == null) {
      if (maxDate == null) {
        controller.dateTimeSelected = DateTime.now();
      } else {
        controller.dateTimeSelected =
            maxDate!.subtract(const Duration(seconds: 5));
      }
    } else {
      controller.dateTimeSelected = dateTimeInited!;
    }
    //
    var dateFormat = formatDateTime.split(' ').first;
    dateFormat = dateFormat.split(',').first;
    if (dateFormat.startsWith("y") && dateFormat.endsWith("d")) {
      dateOrder = DatePickerDateOrder.ymd;
    } else if (dateFormat.startsWith("y") && dateFormat.endsWith("m")) {
      dateOrder = DatePickerDateOrder.ymd;
    } else if (dateFormat.startsWith("d") && dateFormat.endsWith("y")) {
      dateOrder = DatePickerDateOrder.dmy;
    } else {
      dateOrder = DatePickerDateOrder.mdy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onSelected(controller.dateTimeSelected);
        Get.delete<DateTimeSelectorController>();
        return true;
      },
      child: BottomSheetRounded(
        title: Text(
          S.of(context).selectDate.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500)
              .apply(color: Theme.of(context).primaryColor),
        ),
        isWrapContent: true,
        onLeadingClicked: () {
          onSelected(controller.dateTimeSelected);
          Get.delete<DateTimeSelectorController>();
        },
        leadingWidget: Padding(
          key: const ValueKey('done'),
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).done,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        rightActionWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).cancel,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildTab(context),
              const SizedBox(height: 15),
              Expanded(
                child: _buildTabBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: TabBar(
        controller: controller.tabController,
        isScrollable: false,
        //indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
        //labelColor: Colors.white,
        unselectedLabelColor: Theme.of(context).primaryColor,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppProperties.circleRadius - 1),
          color: Theme.of(context).primaryColor,
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.date_range_rounded),
                const SizedBox(width: 10),
                Obx(
                  () => Text(DateUtil.formatDate(controller.dateTimeSelected,
                      format: formatDateTime)),
                ),
              ],
            ),
          ),
          if (!controller.isOnlyDate)
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer_rounded),
                  const SizedBox(width: 10),
                  Obx(
                    () => Text(DateUtil.formatDate(controller.dateTimeSelected,
                        format: DateFormats.hHmm)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TabBarView(
        controller: controller.tabController,
        children: [
          Obx(
            () => CupertinoDatePicker(
                maximumDate: maxDate,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: controller.dateTimeSelected,
                use24hFormat: true,
                onDateTimeChanged: (DateTime newDateTime) {
                  controller.onSelectDate(newDateTime);
                },
                dateOrder: dateOrder),
          ),
          if (!controller.isOnlyDate)
            Obx(
              () => CupertinoDatePicker(
                maximumDate: maxDate,
                minimumDate: minDate,
                mode: CupertinoDatePickerMode.time,
                initialDateTime: controller.dateTimeSelected,
                use24hFormat: true,
                onDateTimeChanged: (DateTime newDateTime) {
                  controller.onSelectTime(newDateTime);
                },
              ),
            ),
        ],
      ),
    );
  }
}
