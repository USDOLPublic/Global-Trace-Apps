import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class TimeFilterView extends GetView<TimeFilterController> {
  const TimeFilterView({Key? key}) : super(key: key);

  void _applyFilterOnClicked() {
    Get.back<DateRangeModel>(result: controller.getRangeDate());
  }

  void _resetFilterOnClicked() {
    controller.cycleSelected = InputItem.empty();
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = Get.statusBarHeight / Get.pixelRatio;
    double scaffoldContentHeight = Get.height - appBarHeight - statusBarHeight;
    double heightFactor = scaffoldContentHeight / Get.height;
    return FractionallySizedBox(
      heightFactor: heightFactor,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).cycle,
                      style: const TextStyle(
                        color: AppColors.grey600,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Obx(
                    () => TagSelectorInput(
                        itemList: controller.cycleDateTimeList,
                        seleted: controller.cycleSelected,
                        onChanged: (InputItem? item) {
                          controller.onChangeCycleSelected(item);
                        }),
                  ),
                ],
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
            if (controller.cycleSelected.isNotEmpty()) {
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
