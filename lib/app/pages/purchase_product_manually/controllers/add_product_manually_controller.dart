import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class AddProductManuallyController extends GetxController {
  final formGlobalKey = GlobalKey<FormState>();
  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  final _formDefinitionLoaded = false.obs;
  bool get formDefinitionLoaded => _formDefinitionLoaded.value;
  set formDefinitionLoaded(bool value) => _formDefinitionLoaded.value = value;

  late final List<ProductDefinitionAttributeModel> _definitionAttributes;

  ProductDefinitionModel? _definition;
  List<FormFieldInputController> inputFieldControllers =
      <FormFieldInputController>[];
  late final PurchaseHttpService _purchaseHttpService;

  @override
  void onInit() {
    _purchaseHttpService = Get.find<PurchaseHttpService>();
    super.onInit();
  }

  @override
  void onReady() {
    _initForm();
    super.onReady();
  }

  void _initForm() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    if (await NetworkUtil.isConnected()) {
      await StaticResourceHelper().cachePurchaseProductDefinition(
        _purchaseHttpService,
      );
    }
    _definition = StaticResourceHelper().getPurchaseProductDefinition();
    _definitionAttributes = _definition?.productDefinitionAttributes ?? [];
    formDefinitionLoaded = true;
    processingDialog.hide();
  }

  void formInputOnChange() {
    _checkFormValidation();
  }

  void _checkFormValidation() {
    List<bool> fields = inputFieldControllers.map((e) => e.isValid()).toList();
    if ((formGlobalKey.currentState?.validate() ?? false) &&
        fields.every((element) => element)) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }

  void inputOnChanged() {
    _checkFormValidation();
  }

  List<Widget> buildInputForm(BuildContext context) {
    List<Widget> inputs = <Widget>[];
    for (var attribute in _definitionAttributes) {
      Widget? inputField;
      dynamic formFieldController;
      String tagId = attribute.attributeId ?? '';
      switch (attribute.attribute?.category) {
        case FieldCategory.text:
          formFieldController = Get.put(
            TextInputController(
              definitionAttribute: attribute,
              onChangedValue: inputOnChanged,
            ),
            tag: tagId,
          );
          inputField = TextInputWidget(
            id: tagId,
          );
          break;
        case FieldCategory.percentage:
          formFieldController = Get.put(
            PercentageInputController(
              definitionAttribute: attribute,
              onChangedValue: inputOnChanged,
            ),
            tag: tagId,
          );
          inputField = PercentageInputWidget(
            id: tagId,
          );
          break;
        case FieldCategory.number:
          formFieldController = Get.put(
            NumberInputController(
              definitionAttribute: attribute,
              onChangedValue: inputOnChanged,
            ),
            tag: tagId,
          );
          inputField = NumberInputWidget(
            id: tagId,
          );
          break;
        case FieldCategory.numberUnitPair:
          formFieldController = Get.put(
            NumberUnitInputController(
              definitionAttribute: attribute,
              onChangedValue: inputOnChanged,
            ),
            tag: tagId,
          );
          inputField = NumberUnitInputWidget(
            id: tagId,
          );
          break;
        case FieldCategory.list:
          formFieldController = Get.put(
            DropdownInputController(
              definitionAttribute: attribute,
              onChangedValue: inputOnChanged,
            ),
            tag: tagId,
          );
          inputField = DropdownInputWidget(
            id: tagId,
          );
          break;
        case FieldCategory.countryLocation:
          formFieldController = Get.put(
            CountryProvinceDistrictInputController(
              definitionAttribute: attribute,
              onChangedValue: inputOnChanged,
            ),
            tag: tagId,
          );
          inputField = CountryProvinceDistrictInputWidget(
            id: tagId,
          );
          break;
        case FieldCategory.attachments:
          formFieldController = Get.put(
            FileAttachmentInputController(
              definitionAttribute: attribute,
              onChangedValue: inputOnChanged,
            ),
            tag: tagId,
          );
          inputField = FileAttachmentInputWidget(
            id: tagId,
          );
          break;
        case FieldCategory.date:
          formFieldController = Get.put(
            DateInputController(
              definitionAttribute: attribute,
              onChangedValue: inputOnChanged,
            ),
            tag: tagId,
          );
          inputField = DateInputWidget(
            id: tagId,
          );
          break;
      }
      if (inputField != null) {
        inputs.add(inputField);
        inputs.add(const SizedBox(height: 16));
      }
      if (formFieldController != null) {
        inputFieldControllers.add(
          formFieldController as FormFieldInputController,
        );
      }
    }
    return inputs;
  }

  ManualAddedProductRequest getProductAdded() {
    List<AttributeRequest> attributes = <AttributeRequest>[];
    for (var element in inputFieldControllers) {
      AttributeRequest requestValue = element.getValue();
      if (requestValue.value != null) {
        attributes.add(requestValue);
      }
    }
    inputFieldControllers
        .map(
          (e) => e.getValue(),
        )
        .toList();
    return ManualAddedProductRequest(
      isManualAdded: true,
      code: _definition?.id ?? '',
      attributes: attributes,
    );
  }
}
