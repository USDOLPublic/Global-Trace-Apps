import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class RecordProductView extends GetView<RecordProductController> {
  const RecordProductView({super.key});

  void _saveOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    String result = await controller.saveRecordProduct();
    if (result.isNotEmpty) {
      Get.back<String>(result: result);
    }
  }

  void _onChangeUnit(InputItem? item) {
    if (item != null) {
      controller.unitSelected = item;
    } else {
      controller.unitSelected = InputItem.empty();
    }
  }

  void _onChangeDateTime(DateTime? date) {
    if (date != null) {
      controller.datetimeSelected = date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).recordByProduct,
      ),
      body: _buildRecordByProductForm(context),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return BottomAction(
      childContent: Obx(
        () {
          bool enable = controller.enableSaveButton;
          return ElevatedButton(
            key: const ValueKey('save'),
            style: ElevatedBtnStyle.enable(),
            onPressed: enable ? () => _saveOnClicked(context) : null,
            child: Text(S.of(context).save),
          );
        },
      ),
    );
  }

  Widget _buildRecordByProductForm(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('singleChildScrollView'),
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formGlobalKey,
          onChanged: controller.formInputOnChange,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowInputWidget(
                firstInput: TextFieldInput(
                  key: const ValueKey('totalWeight'),
                  labelText: S.of(context).totalWeight,
                  inputController: controller.weightTextController,
                  tagId: "weight",
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegexPattern.numericText),
                    NumericTextFormatter(),
                  ],
                  validator: controller.totalWeightValidation,
                ),
                secondInput: Obx(
                  () => DropdownInput(
                    key: const ValueKey('unit'),
                    itemList: ginnerTransportWeightUnits,
                    selected: controller.unitSelected,
                    label: S.of(context).unit,
                    hint: S.of(context).unit,
                    verticalMargin: 0,
                    onChanged: _onChangeUnit,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(
                  () => DateTimeInput(
                    key: const ValueKey('dateAndTime'),
                    onChanged: _onChangeDateTime,
                    selected: controller.datetimeSelected,
                    label: S.of(context).dateAndTime,
                    hint: S.of(context).dateAndTime,
                    isAllowingGreaterThanToday: false,
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(() {
                  List<String> fileList = controller.filesPathSelected;
                  return UploadFileInput(
                    title: S.of(context).uploadProof,
                    filesSelected: fileList,
                    onAddedNewFile: controller.pickPackingFile,
                    onRemovedFile: controller.removePackingFile,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
