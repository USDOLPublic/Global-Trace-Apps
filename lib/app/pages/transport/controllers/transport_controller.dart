import 'dart:async';

import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class TransportController extends GetxController {
  late final TransportPartnerCacheService _transportPartnerCache;
  late final TransportHttpService _transportHttp;
  late final PendingRequestCacheService _pendingRequestCache;
  late final TransportScheduleSending _transportScheduleSending;
  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  final formGlobalKey = GlobalKey<FormState>();

  final _transporterList = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get transporterList => _transporterList.value;

  final _transporter = InputItem.empty().obs;
  InputItem get transporterSelected => _transporter.value;
  set transporterSelected(InputItem value) {
    _transporter.value = value;
    _checkFormValidation();
  }

  final Rxn<DateTime> _datetimeSelected = Rxn<DateTime>();
  DateTime? get datetimeSelected => _datetimeSelected.value;
  set datetimeSelected(DateTime? value) {
    _datetimeSelected.value = value;
    _checkFormValidation();
  }

  final _unitSelected = ginnerTransportWeightUnits.first.obs;
  InputItem get unitSelected => _unitSelected.value;
  set unitSelected(InputItem value) {
    _unitSelected.value = value;
    _updateWeightAsPurchaseWeight();
    _checkFormValidation();
  }

  final _filesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathSelected => _filesPathSelected.value;
  set filesPathSelected(List<String> value) => _filesPathSelected.value = value;

  final _transportProducts = <ProductModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<ProductModel> get transportProducts => _transportProducts.value;
  set transportProducts(List<ProductModel> value) {
    _transportProducts.value = value;
    _transportProducts.refresh();
    if (value.isNotEmpty) {
      _updateWeightAsPurchaseWeight();
    }
    _checkFormValidation();
  }

  TextEditingController totalWeightTextController = TextEditingController();
  TextEditingController packingListNumberTextController =
      TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode packingNode = FocusNode();

  StreamSubscription? _subTransportPartner;
  ProcessingDialog? _processingDialog;

  int get totalWeight {
    String strVal = totalWeightTextController.text.trim().toNumericText;
    return int.tryParse(strVal) ?? 0;
  }

  String get packingListNumber {
    return packingListNumberTextController.text.trim();
  }

  @override
  void onInit() {
    _transportPartnerCache = Get.find<TransportPartnerCacheService>();
    _transportHttp = Get.find<TransportHttpService>();
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
    _transportScheduleSending = TransportScheduleSending(
      fileHttpService: Get.find<FileHttpService>(),
      httpService: _transportHttp,
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
    await _subTransportPartner?.cancel();
    super.onClose();
  }

  Future<void> _initData() async {
    _processingDialog = ProcessingDialog.show();
    await _transportPartnerCache.init();
    _subTransportPartner = _transportPartnerCache.repo.dataStream
        .listen((Map<String, TransportPartner> event) {
      if (event.isNotEmpty) {
        _processingDialog?.hide();
        List<TransportPartner> partners = event.values.toList();
        _transporterList.clear();
        for (TransportPartner partner in partners) {
          _transporterList.add(
              InputItem(displayLabel: partner.name ?? "", value: partner.id));
        }
        _transporterList.refresh();
      }
    });

    //cache partner
    await _loadPartner();
  }

  Future<void> _loadPartner() async {
    var resp = await _transportHttp.getTransportPartners();
    if (resp.isSuccess() && resp.data != null) {
      Map<String, TransportPartner> mapData = <String, TransportPartner>{};
      for (var e in resp.data!) {
        mapData[e.id] = e;
      }
      if (mapData.isNotEmpty) {
        _transportPartnerCache.repo.assignAll(mapData);
      } else {
        _processingDialog?.hide();
      }
    } else {
      _processingDialog?.hide();
    }
  }

  void _checkFormValidation() {
    if (transporterSelected.isNotEmpty() &&
        totalWeight > 0 &&
        unitSelected.isNotEmpty() &&
        packingListNumber.isNotEmpty &&
        filesPathSelected.isNotEmpty &&
        datetimeSelected != null &&
        transportProducts.isNotEmpty &&
        (formGlobalKey.currentState?.validate() ?? false)) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }

  void formInputOnChange() {
    _checkFormValidation();
  }

  String? totalWeightValidation(String? value) {
    double totalWeightOfProducts = _getTotalWeightOfProducts();
    double totalWeightOfProductsByUnit = WeightConverter.to(
      value: totalWeightOfProducts,
      sourceUnit: defaultWeightUnit.value,
      targetUnit: unitSelected.value,
    ).ceil().toDouble();
    if (value != null && totalWeight <= 0) {
      if (value.isEmpty) {
        return S.current.totalWeightIsRequired;
      }
      return S.current.totalWeightInvalid;
    } else if (value != null && totalWeight < totalWeightOfProductsByUnit) {
      return S.current.theWeightTransportMustBeLeast(
        totalWeightOfProductsByUnit.toNumericFormat(),
      );
    } else {
      return null;
    }
  }

  void pickPackingFile(String path) {
    filesPathSelected.add(path);
    _filesPathSelected.refresh();
    _checkFormValidation();
  }

  void removePackingFile(String path) {
    filesPathSelected.removeWhere((element) => element == path);
    _filesPathSelected.refresh();
    _checkFormValidation();
  }

  double _getTotalWeightOfProducts() {
    double totalWeightValue = 0;
    for (var product in transportProducts) {
      double? weightValue = product.getTotalWeight();
      if (weightValue != null) {
        totalWeightValue += weightValue;
      }
    }
    return totalWeightValue;
  }

  void _updateWeightAsPurchaseWeight() {
    double totalWeightOfProducts = _getTotalWeightOfProducts();
    _updateWeightAsUnit(
      weightValue: totalWeightOfProducts,
      sourceUnit: defaultWeightUnit.value,
      targetUnit: unitSelected.value,
    );
  }

  void _updateWeightAsUnit({
    required double weightValue,
    required String sourceUnit,
    required String targetUnit,
  }) {
    int weightWithCurrentUnit = WeightConverter.to(
      value: weightValue,
      sourceUnit: sourceUnit,
      targetUnit: targetUnit,
    ).ceil();
    if (weightWithCurrentUnit > 0) {
      totalWeightTextController.text =
          weightWithCurrentUnit.toString().toNumericFormat();
    } else {
      totalWeightTextController.text = '';
    }
  }

  TransportRequest _getTransportPayload() {
    List<String> productIds = [];
    for (var product in transportProducts) {
      if (!product.isAddByManualForm &&
          product.productCodeManual == null &&
          product.id != null) {
        productIds.add(product.id!);
      }
    }
    return TransportRequest(
      productIds: productIds,
      products: transportProducts,
      toFacilityId: transporterSelected.value,
      toFacilityName: transporterSelected.displayLabel,
      weightUnit: unitSelected.value,
      totalWeight: totalWeight.toDouble(),
      packingListNumber: packingListNumber,
      transactedAt:
          (datetimeSelected ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000,
      localPackingLists: filesPathSelected,
    );
  }

  Future<void> _savePendingTransport(TransportRequest payload) async {
    PendingRequestModel pending = PendingRequestModel.pending(
      payload.toJson(),
      RequestType.transport,
    );
    await _pendingRequestCache.init();
    await _pendingRequestCache.repo.put(pending.id, pending);
  }

  Future<String> saveTransport() async {
    TransportRequest payload = _getTransportPayload();
    final processingDialog = ProcessingDialog.show();
    final result = await _transportScheduleSending.sendRequestTransport(
      payload,
    );
    processingDialog.hide();
    if (result.isSuccess()) {
      return S.current.dataSaved;
    }
    if (OfflineHttpStatus.pendingStatus.contains(result.statusCode)) {
      _savePendingTransport(payload);
      return S.current.noInternetSubmitData;
    }
    SnackBars.error(message: result.getErrorMessage()).show(duration: 5000);
    return '';
  }
}
