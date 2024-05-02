import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class RespondToRequestView extends GetView<RespondToRequestController> {
  const RespondToRequestView({Key? key}) : super(key: key);

  void _onSubmitTap(BuildContext context) async {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    String result = await controller.onSubmit();
    if (result.isNotEmpty) {
      Get.back<String>(result: result);
    }
  }

  void _onChangePriority(InputItem? item) {
    if (item != null) {
      controller.prioritySelected = item;
    } else {
      controller.prioritySelected = InputItem.empty();
    }
  }

  void _onChangeDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      controller.dateTime = dateTime;
    }
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
    if (listLaborRisks.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).respondToRequest,
        hasCloseButton: true,
        hasBackButton: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: controller.formGlobalKey,
          onChanged: controller.formInputOnChange,
          child: Padding(
            padding: const EdgeInsets.all(AppProperties.contentMargin),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Obx(
                  () => DateTimeInput(
                    key: const ValueKey("startDateTimePicker"),
                    label: S.of(context).dateAndTime,
                    hint: S.of(context).dateAndTime,
                    selected: controller.dateTime,
                    isAllowingGreaterThanToday: false,
                    formatDateTime: AppProperties.dateTimeFormatDefault,
                    onChanged: _onChangeDateTime,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => DropdownInput(
                    key: const ValueKey('priority'),
                    itemList: controller.priorities,
                    selected: controller.prioritySelected,
                    label: S.of(context).priority,
                    hint: S.of(context).priority,
                    onChanged: _onChangePriority,
                    verticalMargin: 0,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => GestureDetector(
                    onTap: controller.numIndicatorAdded == null
                        ? _addIndicatorClick
                        : _editIndicatorClick,
                    child: _indicatorsWidget(context),
                  ),
                ),
                const SizedBox(height: 16),
                TextFieldInput(
                  key: const ValueKey('noteInput'),
                  labelText: S.of(context).notes,
                  inputController: controller.noteTextController,
                  textInputAction: TextInputAction.newline,
                  tagId: "note",
                  maxLines: 5,
                  validator: (String? value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value.length > 255) {
                      return S.of(context).notesMustShorterThan;
                    } else {
                      return null;
                    }
                  },
                ),
                const Divider(height: 32),
                TextFieldInput(
                  key: const ValueKey('reportNumberInput'),
                  labelText: S.of(context).reportNumber,
                  inputController: controller.auditNumberTextController,
                  textInputAction: TextInputAction.done,
                  tagId: "reportNumber",
                ),
                const SizedBox(height: 16),
                Obx(() {
                  List<String> fileList = controller.filesPathSelected;
                  return UploadFileInput(
                    title: S.of(context).uploadFile,
                    filesSelected: fileList,
                    onAddedNewFile: controller.pickFile,
                    onRemovedFile: controller.removeFile,
                    fileFormats: const ['jpg', 'png'],
                  );
                }),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomAction(
          key: const ValueKey('submitResponse'),
          isEnableBtn: controller.enableSaveButton,
          titleBtn: S.of(context).submit,
          onPress: () => _onSubmitTap(context),
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      height: AppProperties.inputHight,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
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
