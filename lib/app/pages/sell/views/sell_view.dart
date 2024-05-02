import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class SellView extends GetView<SellController> {
  const SellView({Key? key}) : super(key: key);

  void _onChangePurchaser(InputItem? item) {
    if (item != null) {
      controller.purchaserSelected = item;
    } else {
      controller.purchaserSelected = InputItem.empty();
    }
  }

  void _onChangePurchaserSearch(String text) {
    if (text.isEmpty || text.trim().isEmpty) {
      controller.purchaserTextController.clear();
      controller.purchaserSelected = InputItem.empty();
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

  void _addSellProducts(BuildContext context) async {
    //Hide keyboard
    KeyboardUtils.forceHideKeyboard(context);
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.sellProductList,
      arguments: List<ProductModel>.from(controller.sellProducts),
    );
    if (result != null && result is List<ProductModel>) {
      controller.sellProducts = result;
    }
  }

  void _saveOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    String result = await controller.saveSell();
    if (result.isNotEmpty) {
      Get.back<String>(result: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).sell,
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
              products: controller.sellProducts,
              addProductOnTap: () => _addSellProducts(context),
            ),
          ),
          const SizedBox(height: 8),
          SearchInput<InputItem>(
            searchController: controller.purchaserTextController,
            searchFocus: controller.purchaserNode,
            labelText: S.of(context).purchaser,
            suggestionsCallback: (pattern) async {
              return await controller.loadListPurchaser(pattern);
            },
            itemBuilder: (context, facility) {
              return ListTile(
                key: ValueKey(facility.value),
                title: Text(facility.displayLabel),
              );
            },
            onSuggestionSelected: _onChangePurchaser,
            onChanged: _onChangePurchaserSearch,
          ),
          RowInputWidget(
            firstInput: TextFieldInput(
              key: const ValueKey('totalPrice'),
              labelText: S.of(context).totalPriceOptional,
              inputController: controller.priceTextController,
              tagId: "price",
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegexPattern.numericText),
                NumericTextFormatter(),
              ],
              onFieldSubmitted: (_) {
                controller.invoiceNode.requestFocus();
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
              key: const ValueKey('invoiceNumber'),
              labelText: S.of(context).invoiceNumber,
              inputController: controller.invoiceTextController,
              tagId: "invoiceOrderNumber",
              focusNode: controller.invoiceNode,
              onFieldSubmitted: (_) {
                controller.packingNode.requestFocus();
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() {
              List<String> fileList = controller.invoiceFilesPathSelected;
              return UploadFileInput(
                title: S.of(context).uploadInvoice,
                filesSelected: fileList,
                onAddedNewFile: controller.pickInvoice,
                onRemovedFile: controller.removeInvoiceFile,
              );
            }),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFieldInput(
              key: const ValueKey('packingNumber'),
              labelText: S.of(context).packingListNumber,
              inputController: controller.packingTextController,
              tagId: "purchaseOrderNumber",
              focusNode: controller.packingNode,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() {
              List<String> fileList = controller.packingFilesPathSelected;
              return UploadFileInput(
                title: S.of(context).uploadPackingList,
                filesSelected: fileList,
                onAddedNewFile: controller.pickPacking,
                onRemovedFile: controller.removePackingFile,
              );
            }),
          ),
        ],
      ),
    );
  }
}
