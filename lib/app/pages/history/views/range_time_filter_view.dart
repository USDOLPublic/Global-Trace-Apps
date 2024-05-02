import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class RangeTimeFilterView extends GetView<RangeTimeFilterController> {
  const RangeTimeFilterView({Key? key}) : super(key: key);

  void _applyFilterOnClicked() {
    Get.back<DateRangeModel>(result: controller.rangeSelected);
  }

  void _resetFilterOnClicked() {
    Get.back<DateRangeModel>(result: DateRangeModel());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 560,
      child: BottomSheetRounded(
        title: Text(
          S.of(context).dateRange,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.grey700,
            fontWeight: FontWeight.w600,
          ),
        ),
        isWrapContent: false,
        leadingWidget: const SizedBox.shrink(),
        rightActionWidget: const SizedBox.shrink(),
        body: _buildFilterBody(context),
      ),
    );
  }

  Widget _buildFilterBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppProperties.contentMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.range,
                  dayTextStyle: const TextStyle(
                    color: AppColors.grey600,
                  ),
                  selectedDayTextStyle: const TextStyle(
                    color: AppColors.grey600,
                  ),
                  controlsTextStyle: const TextStyle(
                    color: AppColors.green800,
                  ),
                  weekdayLabelTextStyle: const TextStyle(
                    color: AppColors.green800,
                  ),
                  disabledDayTextStyle: const TextStyle(
                    color: AppColors.grey300,
                  ),
                  yearTextStyle: const TextStyle(
                    color: AppColors.grey600,
                  ),
                  lastDate: DateTime.now(),
                ),
                value: controller.rangeSelected?.toList() ?? [],
                onValueChanged: (dates) {
                  controller.updateRange(dates);
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              bool isEnable = controller.isEnableApply;
              return ElevatedButton(
                onPressed: isEnable ? () => _applyFilterOnClicked() : null,
                child: Text(S.of(context).apply),
                style: ElevatedBtnStyle.enable(),
              );
            }),
          ),
          Obx(() {
            if (controller.rangeSelected != null &&
                controller.rangeSelected!.isNotEmpty()) {
              return SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _resetFilterOnClicked,
                  child: Text(
                    S.of(context).reset,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
