import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class TransportView extends GetView<TransportController> {
  const TransportView({Key? key}) : super(key: key);

  void _onChangeTransporter(InputItem? item) {
    if (item != null) {
      controller.transporterSelected = item;
    } else {
      controller.transporterSelected = InputItem.empty();
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

  void _addTransportProducts(BuildContext context) async {
    //Hide keyboard
    KeyboardUtils.forceHideKeyboard(context);
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.transportProductList,
      arguments: List<ProductModel>.from(controller.transportProducts),
    );
    if (result != null && result is List<ProductModel>) {
      controller.transportProducts = result;
    }
  }

  void _saveOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    String result = await controller.saveTransport();
    if (result.isNotEmpty) {
      Get.back<String>(result: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).transport,
      ),
      body: SingleChildScrollView(
        key: const ValueKey('singleChildScrollView'),
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: _buildSellForm(context),
        ),
      ),
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

  Widget _buildSellForm(BuildContext context) {
    return Form(
      key: controller.formGlobalKey,
      onChanged: () {
        controller.formInputOnChange();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => AddProductButtonWidget(
              products: controller.transportProducts,
              addProductOnTap: () => _addTransportProducts(context),
            ),
          ),
          Obx(
            () => DropdownInput(
              key: const ValueKey('transporter'),
              itemList: controller.transporterList,
              selected: controller.transporterSelected,
              label: S.of(context).transporter,
              hint: S.of(context).transporter,
              onChanged: _onChangeTransporter,
              verticalMargin: AppProperties.lineSpace,
            ),
          ),
          RowInputWidget(
            firstInput: TextFieldInput(
              key: const ValueKey('totalWeight'),
              labelText: S.of(context).totalWeight,
              inputController: controller.totalWeightTextController,
              tagId: "weight",
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegexPattern.numericText),
                NumericTextFormatter(),
              ],
              validator: controller.totalWeightValidation,
              onFieldSubmitted: (_) {
                controller.packingNode.requestFocus();
                return null;
              },
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
            child: TextFieldInput(
              key: const ValueKey('packingListNumber'),
              labelText: S.of(context).packingListNumber,
              inputController: controller.packingListNumberTextController,
              tagId: "packingListNumber",
              focusNode: controller.packingNode,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() {
              List<String> fileList = controller.filesPathSelected;
              return UploadFileInput(
                title: S.of(context).uploadTransportationLog,
                filesSelected: fileList,
                onAddedNewFile: controller.pickPackingFile,
                onRemovedFile: controller.removePackingFile,
              );
            }),
          ),
        ],
      ),
    );
  }
}
