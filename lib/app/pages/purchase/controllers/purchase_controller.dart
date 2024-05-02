import 'dart:async';

import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class PurchaseController extends GetxController {
  late final PurchasePartnerCacheService _purchasePartnerCache;
  late final PendingRequestCacheService _pendingRequestCache;
  late final PurchaseHttpService _purchaseHttp;
  late final PurchaseScheduleSending _purchaseScheduleSending;
  final formGlobalKey = GlobalKey<FormState>();

  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  //data
  final _sellerList = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get sellers => _sellerList.value;

  final _sellerSelected = InputItem.empty().obs;
  InputItem get sellerSelected => _sellerSelected.value;
  set sellerSelected(InputItem value) {
    _sellerSelected.value = value;
    sellerTextController.text = value.displayLabel;
    _checkFormValidation();
  }

  final _currencySelected = currencyUnits.first.obs;
  InputItem get currencySelected => _currencySelected.value;
  set currencySelected(InputItem value) {
    _currencySelected.value = value;
  }

  final Rxn<DateTime> _datetimeSelected = Rxn<DateTime>();
  DateTime? get datetimeSelected => _datetimeSelected.value;
  set datetimeSelected(DateTime? value) {
    _datetimeSelected.value = value;
    _checkFormValidation();
  }

  final RxList<ProductModel> _purchaseProducts = RxList.empty();
  // ignore: invalid_use_of_protected_member
  List<ProductModel> get purchaseProducts => _purchaseProducts.value;
  set purchaseProducts(List<ProductModel> value) {
    _purchaseProducts.value = value;
  }

  final _slipFilesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get slipFilesPathSelected => _slipFilesPathSelected.value;
  set slipFilesPathSelected(List<String> value) =>
      _slipFilesPathSelected.value = value;

  final TextEditingController orderNumberTextController =
      TextEditingController();
  final TextEditingController priceTextController = TextEditingController();
  final TextEditingController sellerTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final FocusNode orderNode = FocusNode();
  final FocusNode priceNode = FocusNode();
  final FocusNode sellerNode = FocusNode();

  StreamSubscription? _subPurchasePartner;
  StreamSubscription? _subCertificationStream;
  ProcessingDialog? _processingDialog;

  String get orderNumber {
    return orderNumberTextController.text.trim();
  }

  int get price {
    if (priceTextController.text.trim().isEmpty) {
      return 0;
    }
    String strVal = priceTextController.text.trim().toNumericText;
    return int.tryParse(strVal) ?? -1;
  }

  @override
  void onInit() {
    _purchasePartnerCache = Get.find<PurchasePartnerCacheService>();
    _purchaseHttp = Get.find<PurchaseHttpService>();
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
    _purchaseScheduleSending = PurchaseScheduleSending(
      fileHttpService: Get.find<FileHttpService>(),
      purchaseHttpService: _purchaseHttp,
    );
    super.onInit();
  }

  @override
  void onReady() {
    _initData();
    super.onReady();
  }

  @override
  void onClose() async {
    await _subPurchasePartner?.cancel();
    await _subCertificationStream?.cancel();
    super.onClose();
  }

  Future<void> _initData() async {
    _processingDialog = ProcessingDialog.show();
    await _purchasePartnerCache.init();
    _subPurchasePartner = _purchasePartnerCache.repo.dataStream
        .listen((Map<String, PurchasePartner> event) async {
      sellers.clear();
      //non-farm added when the user is mass-balance profile
      PurchaseSellerConfig? sellerConfig =
          await StaticResourceHelper().getPurchaseSellerConfig();
      bool isSellerRequired = sellerConfig?.isSellerRequired ?? true;
      String nonRoleName = sellerConfig?.nonParticipatingRoleName ?? '';
      if (!isSellerRequired) {
        String nonParticipatingName = S.current.nonParticipatingRole(
          nonRoleName,
        );
        sellers.add(
          InputItem(
            displayLabel: nonParticipatingName,
            value: nonParticipating,
          ),
        );
      }
      //handle when got seller data
      if (event.isNotEmpty) {
        _processingDialog?.hide();
        List<PurchasePartner> partners = event.values.toList();
        for (PurchasePartner partner in partners) {
          String farmGroupId = partner.farmGroupId ?? "";
          String regNumber = partner.businessRegisterNumber ?? "";
          String farmId = partner.farmId ?? "";
          String codeSearch = "";
          if (farmGroupId.isNotEmpty) {
            codeSearch = farmGroupId;
          }
          if (farmId.isNotEmpty) {
            codeSearch += "|$farmId";
          }
          if (regNumber.isNotEmpty) {
            codeSearch += "|$regNumber";
          }
          if (farmGroupId.isNotEmpty && farmId.isNotEmpty) {
            String farmPattern = "$farmGroupId-$farmId";
            codeSearch += "|$farmPattern";
          }
          sellers.add(InputItem(
            displayLabel: partner.name ?? "",
            value: partner.id,
            code: codeSearch,
          ));
        }
      }
      _sellerList.refresh();
    });
    //cache partner
    await _loadPartner();
  }

  Future<List<InputItem>> loadListSeller(String keyword) async {
    return sellers.where((InputItem e) {
      if (e.displayLabel.toLowerCase().contains(keyword.toLowerCase())) {
        return true;
      }
      if (e.code != null && e.code!.isNotEmpty && e.code!.contains(keyword)) {
        return true;
      }
      return false;
    }).toList();
  }

  Future<void> _loadPartner() async {
    var resp = await _purchaseHttp.getPurchasePartners();
    if (resp.isSuccess() && resp.data != null) {
      Map<String, PurchasePartner> mapData = <String, PurchasePartner>{};
      for (var e in resp.data!) {
        mapData[e.id] = e;
      }
      if (mapData.isNotEmpty) {
        _purchasePartnerCache.repo.assignAll(mapData);
      } else {
        _processingDialog?.hide();
      }
    } else {
      _processingDialog?.hide();
    }
  }

  void _checkFormValidation() {
    if (sellerSelected.isNotEmpty() &&
        orderNumber.isNotEmpty &&
        datetimeSelected != null &&
        purchaseProducts.isNotEmpty &&
        slipFilesPathSelected.isNotEmpty &&
        (formGlobalKey.currentState?.validate() ?? false)) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }

  void formInputOnChange() {
    _checkFormValidation();
  }

  String? priceValidation(String? value) {
    value = value?.trim();
    if (value != null && price < 0) {
      return S.current.priceInvalid;
    } else {
      return null;
    }
  }

  void pickSlip(String path) {
    slipFilesPathSelected.add(path);
    _slipFilesPathSelected.refresh();
    _checkFormValidation();
  }

  void removeSlipFile(String path) {
    slipFilesPathSelected.removeWhere((element) => element == path);
    _slipFilesPathSelected.refresh();
    _checkFormValidation();
  }

  void changeProducts(List<ProductModel> products) {
    purchaseProducts = products;
    _purchaseProducts.refresh();
    _checkFormValidation();
  }

  PurchaseRequest _getPurchasePayload() {
    ManualAddedDataRequest? manualAdded;
    List<ManualAddedProductRequest> manuals = <ManualAddedProductRequest>[];
    List<String> productIds = <String>[];
    List<ProductModel> products = <ProductModel>[];
    String? productDefinitionId;
    for (var product in purchaseProducts) {
      if (product.isAddByManualForm && product.manualAdded != null) {
        manuals.add(product.manualAdded!);
        productDefinitionId = product.manualAdded!.code;
      }
      if (!product.isAddByManualForm) {
        if (product.id != null && product.productCodeManual == null) {
          productIds.add(
            product.id!,
          );
        }
        products.add(product);
      }
    }
    if (manuals.isNotEmpty) {
      manualAdded = ManualAddedDataRequest(
        manualAddedProducts: manuals,
        productDefinitionId: productDefinitionId,
      );
    }
    String? fromFacility = sellerSelected.value;
    String? fromFacilityName = sellerSelected.displayLabel;
    if (fromFacility == nonParticipating) {
      fromFacility = null;
      fromFacilityName = S.current.nonParticipating;
    }

    return PurchaseRequest(
      fromFacilityId: fromFacility,
      fromFacilityName: fromFacilityName,
      price: price.toString(),
      currency: currencySelected.value,
      purchaseOrderNumber: orderNumber,
      transactedAt:
          (datetimeSelected ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000,
      localProofs: slipFilesPathSelected,
      manualAddedData: manualAdded,
      productIds: productIds,
      products: products,
    );
  }

  Future<void> _savePendingPurchase(PurchaseRequest payload) async {
    PendingRequestModel pending = PendingRequestModel.pending(
      payload.toJson(),
      RequestType.purchase,
    );
    await _pendingRequestCache.init();
    await _pendingRequestCache.repo.put(pending.id, pending);
  }

  Future<String> savePurchase() async {
    PurchaseRequest payload = _getPurchasePayload();
    final processingDialog = ProcessingDialog.show();
    final result = await _purchaseScheduleSending.sendRequestPurchase(
      payload,
    );
    processingDialog.hide();
    if (result.isSuccess()) {
      return S.current.dataSaved;
    }
    if (OfflineHttpStatus.pendingStatus.contains(result.statusCode)) {
      _savePendingPurchase(payload);
      return S.current.noInternetSubmitData;
    }
    SnackBars.error(message: result.getErrorMessage()).show(duration: 5000);
    return '';
  }
}
