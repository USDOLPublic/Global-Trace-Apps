import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({Key? key}) : super(key: key);

  void _applyFilterOnClicked() {
    FilterModel filter = FilterModel(
      purchaser: controller.purchaserSelected,
      seller: controller.sellerSelected,
    );
    Get.back<FilterModel>(result: filter);
  }

  void _resetFilterOnClicked() {
    controller.purchaserSelected = InputItem.empty();
    controller.sellerSelected = InputItem.empty();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double contentDefaultHeight = mediaQueryData.size.height - AppBar().preferredSize.height - mediaQueryData.padding.top;
    double contentDefaultHeightFactor = contentDefaultHeight / mediaQueryData.size.height;
    return FractionallySizedBox(
      heightFactor: contentDefaultHeightFactor,
      child: BottomSheetRounded(
        title: Text(
          S.of(context).filters,
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
          Expanded(child: _buildFilters(context)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _applyFilterOnClicked,
              child: Text(S.of(context).apply),
            ),
          ),
          Obx(() {
            if (controller.purchaserSelected.isNotEmpty() || controller.sellerSelected.isNotEmpty()) {
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

  Widget _buildFilters(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, S.of(context).purchaser),
          Obx(
            () => TagSelectorInput(
                itemList: controller.purchaserList,
                seleted: controller.purchaserSelected,
                onChanged: (InputItem? item) {
                  controller.onChangePurchaser(item);
                }),
          ),
          const SizedBox(height: AppProperties.contentMargin),
          _buildTitle(context, S.of(context).seller),
          Obx(
            () => TagSelectorInput(
                itemList: controller.sellerList,
                seleted: controller.sellerSelected,
                onChanged: (InputItem? item) {
                  controller.onChangeSeller(item);
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.grey600,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
