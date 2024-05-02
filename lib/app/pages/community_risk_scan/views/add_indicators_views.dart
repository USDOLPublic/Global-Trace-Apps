import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class AddIndicatorsView extends GetView<AddIndicatorController> {
  const AddIndicatorsView({Key? key}) : super(key: key);
  void _doneOnClicked(BuildContext context) async {
    controller.doneAddLaborRisk();
  }

  void _onChangeIndicator(InputItem? item) {
    if (item != null) {
      controller.indicatorSelected = item;
      controller.loadDataSubIndicator();
    } else {
      controller.indicatorSelected = InputItem.empty();
    }
  }

  void _onChangeSubIndicator(InputItem? item) {
    if (item != null) {
      controller.subIndicatorSelected = item;
    } else {
      controller.subIndicatorSelected = InputItem.empty();
    }
  }

  void _onChangeSeverity(InputItem? item) {
    if (item != null) {
      controller.severitySelected = item;
    } else {
      controller.severitySelected = InputItem.empty();
    }
  }

  void _addIndicatorClick() {
    controller.addLaborRisk();
  }

  void _deleteItemLaborRisk(String id) {
    controller.deleteLaborRisk(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).indicators,
      ),
      bottomNavigationBar: Obx(
        () => BottomAction(
          isEnableBtn: controller.laborRisks.isNotEmpty,
          titleBtn: S.of(context).done,
          onPress: () =>
              controller.laborRisks.isNotEmpty ? _doneOnClicked(context) : null,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: _buildBody(context),
            ),
            Obx(
              () => controller.laborRisks.isNotEmpty
                  ? _itemIndicatorAdded(context, controller.laborRisks)
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildAddIndicatorView(context),
      ],
    );
  }

  Widget _buildAddIndicatorView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.k4B4B45.withOpacity(0.04),
            spreadRadius: 20,
            blurRadius: 7,
            offset: const Offset(10, 0), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => DropdownInput(
                key: const ValueKey('indicators'),
                itemList: controller.indicators,
                selected: controller.indicatorSelected,
                label: S.of(context).indicators,
                hint: S.of(context).indicators,
                onChanged: _onChangeIndicator,
                verticalMargin: AppProperties.lineSpace,
              ),
            ),
            Obx(
              () => DropdownInput(
                key: const ValueKey('subIndicator'),
                itemList: controller.subIndicators,
                selected: controller.subIndicatorSelected,
                label: S.of(context).subIndicators,
                hint: S.of(context).subIndicators,
                isDisabled: controller.subIndicators.isEmpty,
                onChanged: _onChangeSubIndicator,
                verticalMargin: AppProperties.lineSpace,
              ),
            ),
            Obx(
              () => DropdownInput(
                key: const ValueKey('severity'),
                itemList: controller.severities,
                selected: controller.severitySelected,
                label: S.of(context).severity,
                hint: S.of(context).severity,
                onChanged: _onChangeSeverity,
                verticalMargin: AppProperties.lineSpace,
              ),
            ),
            Obx(
              () => Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.k4B4B45.withOpacity(0.04),
                      spreadRadius: 20,
                      blurRadius: 7,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                height: 72,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  key: const ValueKey("addIndicator"),
                  style: controller.enableAddButton
                      ? ElevatedBtnStyle.enable()
                      : ElevatedBtnStyle.disable(),
                  onPressed: () {
                    controller.enableAddButton ? _addIndicatorClick() : null;
                  },
                  child: Text(S.of(context).add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemIndicatorAdded(
    BuildContext context,
    List<LaborRisksModel> laborRisksModel,
  ) {
    TextStyle title = const TextStyle(
      color: AppColors.grey200,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );
    TextStyle content = const TextStyle(
      color: AppColors.grey600,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    TextStyle severity = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );
    return ListView.builder(
      itemCount: laborRisksModel.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  _deleteItemLaborRisk(laborRisksModel[index].id ?? "");
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                  child: Icon(
                    Icons.close,
                    color: AppColors.grey200,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).indicators,
                      style: title,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      laborRisksModel[index].indicator?.name ?? "",
                      style: content,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      S.of(context).subIndicators,
                      style: title,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      laborRisksModel[index].subIndicator?.name ?? "",
                      style: content.copyWith(color: AppColors.grey700),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).severity,
                          style: title,
                        ),
                        Text(
                          laborRisksModel[index].severity?.name ?? "",
                          style: severity.copyWith(
                            color: Color(
                                laborRisksModel[index].severity?.color ??
                                    0xff3E415B),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
