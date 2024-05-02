import 'package:usdol/app/core.dart';

class TransformController extends GetxController {
  late final TransformScheduleSending _transformSchedule;
  late final PendingRequestCacheService _pendingRequestCache;
  late final PurchaseHttpService _purchaseHttpService;

  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  final _formDefinitionLoaded = false.obs;
  bool get formDefinitionLoaded => _formDefinitionLoaded.value;
  set formDefinitionLoaded(bool value) => _formDefinitionLoaded.value = value;

  final _inputProducts = <ProductModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<ProductModel> get inputProducts => _inputProducts.value;
  set inputProducts(List<ProductModel> value) {
    _inputProducts.value = value;
    _inputProducts.refresh();
    _checkFormValidation();
  }

  final _outputProducts = <ProductModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<ProductModel> get outputProducts => _outputProducts.value;
  set outputProducts(List<ProductModel> value) {
    _outputProducts.value = value;
    _outputProducts.refresh();
    _checkFormValidation();
  }

  ProductDefinitionModel? _definition;
  late final List<ProductDefinitionAttributeModel> _definitionAttributes;

  @override
  void onInit() {
    _transformSchedule = Get.find<TransformScheduleSending>();
    _purchaseHttpService = Get.find<PurchaseHttpService>();
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
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

  bool isHaveInputProduct() {
    return _definitionAttributes.firstWhereOrNull(
          (element) => element.getAttributeType() == FieldType.productId,
        ) !=
        null;
  }

  void _checkFormValidation() {
    bool inputValid = inputProducts.isNotEmpty || !isHaveInputProduct();
    bool outputValid = outputProducts.isNotEmpty;
    if (inputValid && outputValid) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }

  TransformRequest _getTransformPayload() {
    List<String>? inputProductIds;
    for (var product in inputProducts) {
      if (!product.isAddByManualForm &&
          product.productCodeManual == null &&
          product.id != null) {
        inputProductIds ??= [];
        inputProductIds.add(product.id!);
      }
    }
    OutputProductRequest? outputProduct;
    if (outputProducts.isNotEmpty) {
      String? productDefinitionId;
      List<ManualAddedProductRequest>? outputManuals;
      for (var product in outputProducts) {
        if (product.manualAdded != null) {
          outputManuals ??= [];
          outputManuals.add(product.manualAdded!);
          productDefinitionId = product.manualAdded!.code;
        }
      }
      outputProduct = OutputProductRequest(
        productDefinitionId: productDefinitionId,
        outputProducts: outputManuals,
      );
    }
    return TransformRequest(
      inputProductIds: inputProductIds,
      inputProducts: inputProducts,
      outputProduct: outputProduct,
      createAt: DateTime.now().microsecondsSinceEpoch ~/ 1000,
    );
  }

  Future<void> _savePendingTransformation(TransformRequest payload) async {
    PendingRequestModel pending = PendingRequestModel.pending(
      payload.toJson(),
      RequestType.assignProduct,
    );
    await _pendingRequestCache.init();
    await _pendingRequestCache.repo.put(pending.id, pending);
  }

  Future<String> saveTransformation() async {
    TransformRequest payload = _getTransformPayload();
    final processingDialog = ProcessingDialog.show();
    final result = await _transformSchedule.sendRequestTransform(payload);
    processingDialog.hide();
    if (result.isHaveRespData()) {
      return S.current.dataSaved;
    }
    if (OfflineHttpStatus.pendingStatus.contains(result.statusCode)) {
      _savePendingTransformation(payload);
      return S.current.noInternetSubmitData;
    }
    SnackBars.error(message: result.getErrorMessage()).show(duration: 5000);
    return '';
  }
}
