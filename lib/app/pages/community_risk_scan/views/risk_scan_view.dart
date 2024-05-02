import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class RiskScanView extends GetView<RiskScanController> {
  const RiskScanView({Key? key}) : super(key: key);

  void _saveOnClicked(BuildContext context) async {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    String result = await controller.submitRiskScan();
    if (result.isNotEmpty) {
      Get.back<String>(result: result);
    }
  }

  void _onChangeDateTime(DateTime? date) {
    if (date != null) {
      controller.datetimeSelected = date;
    }
  }

  void _onChangePriority(InputItem? item) {
    if (item != null) {
      controller.prioritySelected = item;
    } else {
      controller.prioritySelected = InputItem.empty();
    }
  }

  void _onChangeSearch(String text) {
    if (text.isEmpty || text.trim().isEmpty) {
      controller.facilityTextController.clear();
      controller.facilitySelected = null;
    }
  }

  void _onChooseSuggestFacility(FacilityRespModel facility) {
    controller.chooseFacility(facility);
  }

  Future<void> _addIndicatorClick() async {
    final dynamic listLaborRisk =
        await Get.toNamed<dynamic>(Routes.addIndicator);
    if (listLaborRisk != null &&
        listLaborRisk is List<LaborRisksModel> &&
        listLaborRisk.isNotEmpty) {
      controller.addIndicators(listLaborRisk);
      setNumIndicatorAdded(listLaborRisk);
    }
  }

  Future<void> _editIndicatorClick() async {
    final dynamic listLaborRisk = await Get.toNamed<dynamic>(
        Routes.addIndicator,
        arguments: controller.listLaborRisks);
    if (listLaborRisk != null && listLaborRisk is List<LaborRisksModel>) {
      controller.addIndicators(listLaborRisk);
      setNumIndicatorAdded(listLaborRisk);
    }
  }

  void setNumIndicatorAdded(List<LaborRisksModel> listLaborRisks) {
    if (controller.isHaveIndicatorAdded()) {
      if (listLaborRisks.length == 1) {
        controller.numIndicatorAdded = S.current.oneIndicatorAdded;
      } else {
        controller.numIndicatorAdded =
            S.current.numIndicatorAdded(listLaborRisks.length);
      }
    } else {
      controller.numIndicatorAdded = null;
    }
  }

  void _onTapUseMyCurrentLocation(BuildContext context) async {
    //Hide keyboard
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    if (controller.locationDetecting) return;
    await controller.detectMyLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).communityRiskScan,
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        child: _buildRiskScanForm(context),
      ),
      bottomNavigationBar: Obx(
        () => BottomAction(
          isEnableBtn: controller.enableSaveButton,
          titleBtn: S.of(context).submit,
          onPress: () => _saveOnClicked(context),
        ),
      ),
    );
  }

  Widget _buildRiskScanForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppProperties.contentMargin),
      child: Form(
        key: controller.formGlobalKey,
        onChanged: () {
          controller.formInputOnChange();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchInput<FacilityRespModel>(
              searchController: controller.facilityTextController,
              searchFocus: controller.facilityNameNode,
              labelText: S.of(context).facilityName,
              suggestionsCallback: (pattern) async {
                return await controller.loadListFacility(pattern);
              },
              onSuggestionSelected: _onChooseSuggestFacility,
              onChanged: _onChangeSearch,
              itemBuilder: (context, facility) {
                return ListTile(
                  key: ValueKey(facility.id),
                  title: FacilityInfoWidget(
                    facility: facility,
                  ),
                );
              },
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFieldInput(
                  key: const ValueKey('location'),
                  labelText: S.of(context).location,
                  inputController: controller.locationTextController,
                  enabled: !controller.useMyLocation,
                  tagId: "location",
                  onFieldSubmitted: (_) {
                    controller.noteFocus.requestFocus();
                    return null;
                  },
                  suffixIcon: controller.useMyLocation
                      ? null
                      : SizedBox(
                          height: 24,
                          width: 24,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                AssetsConst.icEditColor,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 24,
                                width: 10,
                              )
                            ],
                          ),
                        ),
                ),
              ),
            ),
            InkWell(
              onTap: () => _onTapUseMyCurrentLocation(context),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                child: Row(
                  children: [
                    Obx(() {
                      if (controller.locationDetecting) {
                        return const SizedBox(
                          width: 19,
                          height: 19,
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.green600,
                          ),
                        );
                      } else {
                        return Image.asset(
                          AssetsConst.addLocation,
                          width: 19,
                          height: 19,
                        );
                      }
                    }),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      S.of(context).useMyCurrentLocation,
                      style: const TextStyle(
                        color: AppColors.green800,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Obx(
                () => DateTimeInput(
                  onChanged: _onChangeDateTime,
                  selected: controller.datetimeSelected,
                  label: S.of(context).dateAndTime,
                  hint: S.of(context).dateAndTime,
                  isAllowingGreaterThanToday: false,
                  formatDateTime: AppProperties.dateTimeFormatDefault,
                ),
              ),
            ),
            Obx(
              () => DropdownInput(
                key: const ValueKey('priority'),
                itemList: controller.priorities,
                selected: controller.prioritySelected,
                label: S.of(context).priority,
                hint: S.of(context).priority,
                onChanged: _onChangePriority,
                verticalMargin: AppProperties.lineSpace,
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: controller.numIndicatorAdded == null
                    ? _addIndicatorClick
                    : _editIndicatorClick,
                child: _indicatorsWidget(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFieldInput(
                key: const ValueKey('notes'),
                labelText: S.of(context).notes,
                inputController: controller.noteTextController,
                tagId: "notes",
                textInputAction: TextInputAction.newline,
                maxLines: 5,
                focusNode: controller.noteFocus,
                validator: (String? value) {
                  if (value != null && value.isNotEmpty && value.length > 255) {
                    return S.of(context).notesMustShorterThan;
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFieldInput(
                key: const ValueKey('reportNumberInput'),
                labelText: S.of(context).reportNumber,
                inputController: controller.auditNumberTextController,
                textInputAction: TextInputAction.done,
                tagId: "reportNumber",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Obx(() {
                List<String> fileList = controller.filesPathSelected;
                return UploadFileInput(
                  title: S.of(context).uploadFile,
                  filesSelected: fileList,
                  onAddedNewFile: controller.pickFile,
                  onRemovedFile: controller.removeFile,
                  fileFormats: const ['jpg', 'png'],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _indicatorsWidget(BuildContext context) {
    TextStyle? textNormalStyle = const TextStyle(
      color: AppColors.green600,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      height: AppProperties.inputHight,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: !controller.isHaveIndicatorAdded()
                ? Theme.of(context).primaryColor
                : AppColors.white,
          ),
          borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        ),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              controller.numIndicatorAdded ?? S.of(context).indicators,
              style: controller.numIndicatorAdded == null
                  ? textNormalStyle
                  : textNormalStyle.copyWith(color: AppColors.green800),
            ),
          ),
          Obx(
            () => controller.numIndicatorAdded == null
                ? Container(
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.green700,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                    ),
                  )
                : const Icon(
                    Icons.edit,
                    color: AppColors.green700,
                  ),
          )
        ],
      ),
    );
  }
}
