import 'dart:async';

import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class SellController extends GetxController {
  late final SellPartnerCacheService _sellPartnerCache;
  late final SellHttpService _sellHttp;
  late final PendingRequestCacheService _pendingRequestCache;
  late final SellScheduleSending _sellScheduleSending;

  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  final formGlobalKey = GlobalKey<FormState>();

  //data
  final _purchaserList = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get purchaserList => _purchaserList.value;

  final _purchaser = InputItem.empty().obs;
  InputItem get purchaserSelected => _purchaser.value;
  set purchaserSelected(InputItem value) {
    _purchaser.value = value;
    purchaserTextController.text = value.displayLabel;
    _checkFormValidation();
  }

  final _currencySelected = currencyUnits.first.obs;
  InputItem get currencySelected => _currencySelected.value;
  set currencySelected(InputItem value) {
    _currencySelected.value = value;
    _checkFormValidation();
  }

  final Rxn<DateTime> _datetimeSelected = Rxn<DateTime>();
  DateTime? get datetimeSelected => _datetimeSelected.value;
  set datetimeSelected(DateTime? value) {
    _datetimeSelected.value = value;
    _checkFormValidation();
  }

  final _invoiceFilesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get invoiceFilesPathSelected => _invoiceFilesPathSelected.value;
  set invoiceFilesPathSelected(List<String> value) =>
      _invoiceFilesPathSelected.value = value;

  final _packingFilesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get packingFilesPathSelected => _packingFilesPathSelected.value;
  set packingFilesPathSelected(List<String> value) =>
      _packingFilesPathSelected.value = value;

  final _sellProducts = <ProductModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<ProductModel> get sellProducts => _sellProducts.value;
  set sellProducts(List<ProductModel> value) {
    _sellProducts.value = value;
    _sellProducts.refresh();
    _checkFormValidation();
  }

  TextEditingController priceTextController = TextEditingController();
  TextEditingController invoiceTextController = TextEditingController();
  TextEditingController packingTextController = TextEditingController();
  TextEditingController purchaserTextController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode packingNode = FocusNode();
  FocusNode invoiceNode = FocusNode();
  FocusNode purchaserNode = FocusNode();

  StreamSubscription? _subSellPartner;
  ProcessingDialog? _processingDialog;

  int get price {
    if (priceTextController.text.trim().isEmpty) {
      return 0;
    }
    String strVal = priceTextController.text.trim().toNumericText;
    return int.tryParse(strVal) ?? -1;
  }

  String get invoiceNumber {
    return invoiceTextController.text.trim();
  }

  String get packingNumber {
    return packingTextController.text.trim();
  }

  @override
  void onInit() {
    _sellPartnerCache = Get.find<SellPartnerCacheService>();
    _sellHttp = Get.find<SellHttpService>();
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
    _sellScheduleSending = SellScheduleSending(
      fileHttpService: Get.find<FileHttpService>(),
      sellHttpService: _sellHttp,
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
    await _subSellPartner?.cancel();
    super.onClose();
  }

  Future<void> _initData() async {
    _processingDialog = ProcessingDialog.show();
    await _sellPartnerCache.init();
    _subSellPartner = _sellPartnerCache.repo.dataStream
        .listen((Map<String, SellPartner> event) {
      if (event.isNotEmpty) {
        _processingDialog?.hide();
        List<SellPartner> partners = event.values.toList();
        _purchaserList.clear();
        for (SellPartner partner in partners) {
          _purchaserList.add(InputItem(
            displayLabel: partner.name ?? "",
            value: partner.id,
            code: partner.businessRegisterNumber,
          ));
        }
        _purchaserList.refresh();
      }
    });

    //cache partner
    await _loadPartner();
  }

  Future<void> _loadPartner() async {
    var resp = await _sellHttp.getSellPartners();
    if (resp.isSuccess() && resp.data != null) {
      Map<String, SellPartner> mapData = <String, SellPartner>{};
      for (var e in resp.data!) {
        mapData[e.id] = e;
      }
      if (mapData.isNotEmpty) {
        _sellPartnerCache.repo.assignAll(mapData);
      } else {
        _processingDialog?.hide();
      }
    } else {
      _processingDialog?.hide();
    }
  }

  Future<List<InputItem>> loadListPurchaser(String keyword) async {
    return purchaserList.where((InputItem e) {
      if (e.displayLabel.toLowerCase().contains(keyword.toLowerCase())) {
        return true;
      }
      if (e.code != null && e.code!.contains(keyword)) {
        return true;
      }
      return false;
    }).toList();
  }

  void _checkFormValidation() {
    if (purchaserSelected.isNotEmpty() &&
        sellProducts.isNotEmpty &&
        price >= 0 &&
        currencySelected.isNotEmpty() &&
        invoiceFilesPathSelected.isNotEmpty &&
        packingFilesPathSelected.isNotEmpty &&
        invoiceNumber.isNotEmpty &&
        packingNumber.isNotEmpty &&
        datetimeSelected != null &&
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
    if (value != null && price < 0) {
      return S.current.priceInvalid;
    } else {
      return null;
    }
  }

  void pickInvoice(String path) {
    invoiceFilesPathSelected.add(path);
    _invoiceFilesPathSelected.refresh();
    _checkFormValidation();
  }

  void removeInvoiceFile(String path) {
    invoiceFilesPathSelected.removeWhere((element) => element == path);
    _invoiceFilesPathSelected.refresh();
    _checkFormValidation();
  }

  void pickPacking(String path) {
    packingFilesPathSelected.add(path);
    _packingFilesPathSelected.refresh();
    _checkFormValidation();
  }

  void removePackingFile(String path) {
    packingFilesPathSelected.removeWhere((element) => element == path);
    _packingFilesPathSelected.refresh();
    _checkFormValidation();
  }

  SellRequest _getSellPayload() {
    List<String> productIds = [];
    for (var product in sellProducts) {
      if (!product.isAddByManualForm &&
          product.productCodeManual == null &&
          product.id != null) {
        productIds.add(product.id!);
      }
    }
    return SellRequest(
      productIds: productIds,
      products: sellProducts,
      toFacilityId: purchaserSelected.value,
      toFacilityName: purchaserSelected.displayLabel,
      price: price.toString(),
      currency: currencySelected.value,
      invoiceNumber: invoiceNumber,
      packingListNumber: packingNumber,
      transactedAt:
          (datetimeSelected ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000,
      localInvoices: invoiceFilesPathSelected,
      localPackingLists: packingFilesPathSelected,
    );
  }

  Future<void> _savePendingSell(SellRequest payload) async {
    PendingRequestModel pending = PendingRequestModel.pending(
      payload.toJson(),
      RequestType.sell,
    );
    await _pendingRequestCache.init();
    await _pendingRequestCache.repo.put(pending.id, pending);
  }

  Future<String> saveSell() async {
    SellRequest payload = _getSellPayload();
    final processingDialog = ProcessingDialog.show();
    final result = await _sellScheduleSending.sendRequestSell(
      payload,
    );
    processingDialog.hide();
    if (result.isSuccess()) {
      return S.current.dataSaved;
    }
    if (OfflineHttpStatus.pendingStatus.contains(result.statusCode)) {
      _savePendingSell(payload);
      return S.current.noInternetSubmitData;
    }
    SnackBars.error(message: result.getErrorMessage()).show(duration: 5000);
    return '';
  }
}
