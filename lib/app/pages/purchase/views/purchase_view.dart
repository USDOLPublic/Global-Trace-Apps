import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class PurchaseView extends GetView<PurchaseController> {
  const PurchaseView({Key? key}) : super(key: key);

  void _onChangeFarmOrBroker(InputItem? item) {
    if (item != null) {
      controller.sellerSelected = item;
    } else {
      controller.sellerSelected = InputItem.empty();
    }
  }

  void _onChangeFarmOrBrokerSearch(String text) {
    if (text.isEmpty || text.trim().isEmpty) {
      controller.sellerTextController.clear();
      controller.sellerSelected = InputItem.empty();
    }
  }

  void _onChangeCurrency(InputItem? item) {
    if (item != null) {
      controller.currencySelected = item;
    } else {
      controller.currencySelected = InputItem.empty();
    }
  }

  void _onChangeDateTime(DateTime? date) {
    if (date != null) {
      controller.datetimeSelected = date;
    }
  }

  void _saveOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    String result = await controller.savePurchase();
    if (result.isNotEmpty) {
      Get.back<String>(result: result);
    }
  }

  void _addPurchaseProducts() async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.purchaseProductList,
      arguments: List<ProductModel>.from(controller.purchaseProducts),
    );
    if (result != null && result is List<ProductModel>) {
      controller.changeProducts(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).purchase,
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        key: const ValueKey('singleChildScrollView'),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: _buildPurchaseForm(context),
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

  Widget _buildPurchaseForm(BuildContext context) {
    return Form(
      onChanged: () {
        controller.formInputOnChange();
      },
      key: controller.formGlobalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => AddProductButtonWidget(
              products: controller.purchaseProducts,
              addProductOnTap: () => _addPurchaseProducts(),
            ),
          ),
          const SizedBox(height: 8),
          SearchInput<InputItem>(
            searchController: controller.sellerTextController,
            searchFocus: controller.sellerNode,
            labelText: S.of(context).seller,
            suggestionsCallback: (pattern) async {
              return await controller.loadListSeller(pattern);
            },
            itemBuilder: (context, facility) {
              return ListTile(
                key: ValueKey(facility.value),
                title: Text(facility.displayLabel),
              );
            },
            onSuggestionSelected: _onChangeFarmOrBroker,
            onChanged: _onChangeFarmOrBrokerSearch,
          ),
          RowInputWidget(
            firstInput: TextFieldInput(
              key: const ValueKey('totalPrice'),
              labelText: S.of(context).totalPriceOptional,
              inputController: controller.priceTextController,
              tagId: "totalPrice",
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegexPattern.numericText),
                NumericTextFormatter(),
              ],
              focusNode: controller.priceNode,
              onFieldSubmitted: (_) {
                controller.orderNode.requestFocus();
                return null;
              },
              validator: controller.priceValidation,
            ),
            secondInput: Obx(
              () => DropdownInput(
                key: const ValueKey('currency'),
                itemList: currencyUnits,
                selected: controller.currencySelected,
                label: S.of(context).currency,
                hint: S.of(context).currency,
                verticalMargin: 0,
                onChanged: _onChangeCurrency,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFieldInput(
              key: const ValueKey('purchaseOrderNumber'),
              labelText: S.of(context).purchaseOrderNumber,
              inputController: controller.orderNumberTextController,
              tagId: "purchaseOrderNumber",
              focusNode: controller.orderNode,
              textInputAction: TextInputAction.done,
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
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() {
              List<String> fileList = controller.slipFilesPathSelected;
              return UploadFileInput(
                title: S.of(context).uploadReceiptOrPurchaseRecord,
                filesSelected: fileList,
                onAddedNewFile: controller.pickSlip,
                onRemovedFile: controller.removeSlipFile,
              );
            }),
          ),
        ],
      ),
    );
  }
}
