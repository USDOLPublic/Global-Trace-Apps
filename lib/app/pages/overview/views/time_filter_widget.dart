import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class TimeFilterWidget extends GetView<OverviewController> {
  const TimeFilterWidget({
    super.key,
    this.tagId,
  });

  final String? tagId;
  @override
  String? get tag => tagId;

  void _changeDateRangeOnClicked(BuildContext context) {
    _changeCycleDateOnClicked(context);
  }

  void _changeCycleDateOnClicked(BuildContext context) async {
    Get.put(TimeFilterController(range: controller.timeFilterRange));
    final dynamic result = await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const TimeFilterView(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppProperties.circleRadius,
          ),
        ),
      ),
    );
    await Get.delete<TimeFilterController>();
    if (result != null && result is DateRangeModel) {
      controller.filterOnUpdate(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () {
              DateRangeModel timeRange = controller.timeFilterRange;
              bool isNotFilter = timeRange.isEmpty();
              String startDateStr =
                  DateUtil.parseFromDateTime(timeRange.start, "d MMM, yyyy");
              String endDateStr =
                  DateUtil.parseFromDateTime(timeRange.end, "d MMM, yyyy");
              String dateTimeStr = "$startDateStr - $endDateStr";
              return _buildFilterChip(
                context,
                label: isNotFilter ? S.of(context).cycle : dateTimeStr,
                ic: Icons.calendar_today_outlined,
                onTap: () => _changeDateRangeOnClicked(context),
                isActive: !isNotFilter,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    String label = "",
    IconData ic = Icons.access_alarm,
    bool isActive = false,
    void Function()? onTap,
  }) {
    Color forceColor = isActive ? AppColors.green700 : AppColors.grey300;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Chip(
          avatar: Icon(ic, size: 18, color: forceColor),
          label: Text(
            label,
            style: TextStyle(color: forceColor),
          ),
          shape:
              const StadiumBorder(side: BorderSide(color: AppColors.grey300)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
