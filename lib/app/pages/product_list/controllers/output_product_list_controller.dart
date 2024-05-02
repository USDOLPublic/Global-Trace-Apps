import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class OutputProductListController extends ProductListController {
  late final TransformHttpService _httpService;
  final formGlobalKey = GlobalKey<FormState>();

  final _enableAddOutputButton = false.obs;
  bool get enableAddOutputButton => _enableAddOutputButton.value;
  set enableAddOutputButton(bool value) => _enableAddOutputButton.value = value;

  final _formDefinitionLoaded = false.obs;
  bool get formDefinitionLoaded => _formDefinitionLoaded.value;
  set formDefinitionLoaded(bool value) => _formDefinitionLoaded.value = value;

  ProductDefinitionModel? _definition;
  late final List<ProductDefinitionAttributeModel> _definitionAttributes;

  List<FormFieldInputController> inputFieldControllers =
      <FormFieldInputController>[];
  final List<Widget> _inputFieldWidgets = <Widget>[];
  TextEditingController dnaIdTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _httpService = Get.find<TransformHttpService>();
  }

  @override
  void onReady() {
    super.onReady();
    _initForm();
  }

  @override
  bool isHavePermissionManualAdd() {
    return false;
  }

  @override
  bool isHavePermissionScanProduct() {
    return false;
  }

  @override
  bool isHavePermissionInputProduct() {
    return false;
  }

  @override
  Future<BaseResp<ProductModel>> getProductById(String id) async {
    return await _httpService.getAssignProduct(id);
  }

  @override
  bool isUsedProduct(ProductModel product) {
    return product.isTransformed == true;
  }

  @override
  String getReasonProductUsed() {
    return S.current.productAlreadyTransformed;
  }

  @override
  String getPageTitle(BuildContext context) {
    return S.of(context).addOutputProduct;
  }

  void _initForm() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    if (await NetworkUtil.isConnected()) {
      await StaticResourceHelper().cacheSoldProductDefinition(
        _httpService,
      );
    }
    _definition = StaticResourceHelper().getSoldProductDefinition();
    _definitionAttributes = _definition?.productDefinitionAttributes ?? [];
    formDefinitionLoaded = true;
    processingDialog.hide();
  }

  @override
  Widget inputProductFormDetails() {
    return const AddOutPutProductView();
  }

  void _checkOutputFormValidation() {
    List<bool> fields = inputFieldControllers.map((e) => e.isValid()).toList();
    if ((formGlobalKey.currentState?.validate() ?? false) &&
        fields.every((element) => element)) {
      enableAddOutputButton = true;
    } else {
      enableAddOutputButton = false;
    }
  }

  void inputOnChanged() {
    _checkOutputFormValidation();
  }

  bool _hasDNAPermission() {
    return userInfo.hasPermission(PermissionActionDef.assignDna);
  }

  bool _hasAssignQrCodePermission() {
    return userInfo.hasPermission(PermissionActionDef.assignQrCode);
  }

  List<Widget> buildInputForm() {
    if (_inputFieldWidgets.isNotEmpty) {
      return _inputFieldWidgets;
    }
    for (var defineAttribute in _definitionAttributes) {
      if (defineAttribute.isAddManuallyOnly != false) {
        //transform only show isAddManuallyOnly = false
        continue;
      }
      Widget? inputField;
      dynamic formFieldController;
      String tagId = defineAttribute.attributeId ?? '';
      AttributeModel? attribute = defineAttribute.attribute;
      switch (attribute?.category) {
        case FieldCategory.text:
          bool isEnableQRCode = attribute?.type == FieldType.productId &&
              _hasAssignQrCodePermission();

          formFieldController = Get.put(
            TextInputController(
              definitionAttribute: defineAttribute,
              onChangedValue: inputOnChanged,
              isEnableQRCodeInput: isEnableQRCode,
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
              definitionAttribute: defineAttribute,
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
              definitionAttribute: defineAttribute,
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
              definitionAttribute: defineAttribute,
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
              definitionAttribute: defineAttribute,
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
              definitionAttribute: defineAttribute,
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
              definitionAttribute: defineAttribute,
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
              definitionAttribute: defineAttribute,
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
        _inputFieldWidgets.add(inputField);
        _inputFieldWidgets.add(const SizedBox(height: 16));
      }
      if (formFieldController != null) {
        inputFieldControllers.add(
          formFieldController as FormFieldInputController,
        );
      }
    }
    if (_hasDNAPermission()) {
      _inputFieldWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFieldInput(
            key: const ValueKey("dnaId"),
            labelText: S.current.dnaIdOptinal,
            inputController: dnaIdTextController,
            tagId: "dnaId",
            textInputAction: TextInputAction.done,
          ),
        ),
      );
    }
    return _inputFieldWidgets;
  }

  ManualAddedProductRequest _getOutputProductAdded() {
    String? qrCode, dnaId;
    List<AttributeRequest> attributes = <AttributeRequest>[];
    for (var element in inputFieldControllers) {
      AttributeRequest requestValue = element.getValue();
      if (requestValue.value != null) {
        if (requestValue.type == FieldType.productId &&
            _hasAssignQrCodePermission()) {
          qrCode = requestValue.value?.toString();
        }
        attributes.add(requestValue);
      }
    }

    if (_hasDNAPermission()) {
      dnaId = dnaIdTextController.text.trim();
    }

    return ManualAddedProductRequest(
      isManualAdded: true,
      code: _definition?.id ?? '',
      attributes: attributes,
      qrCode: qrCode,
      dnaIdentifier: dnaId,
    );
  }

  void _resetOutputForm() {
    for (var element in inputFieldControllers) {
      element.reset();
    }
    dnaIdTextController.clear();
  }

  void addOutputProduct() {
    ManualAddedProductRequest manualProduct = _getOutputProductAdded();
    bool isAddSuccess = addProductManual(manualProduct);
    if (isAddSuccess) {
      _resetOutputForm();
    }
  }
}
