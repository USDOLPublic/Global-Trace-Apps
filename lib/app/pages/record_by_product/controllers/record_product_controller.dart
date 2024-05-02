import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class RecordProductController extends GetxController {
  late final RecordProductHttpService _recordProductHttp;
  late final PendingRequestCacheService _pendingRequestCache;
  final formGlobalKey = GlobalKey<FormState>();

  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  final _filesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathSelected => _filesPathSelected.value;
  set filesPathSelected(List<String> value) => _filesPathSelected.value = value;

  final _unitSelected = ginnerTransportWeightUnits.first.obs;
  InputItem get unitSelected => _unitSelected.value;
  set unitSelected(InputItem value) {
    _unitSelected.value = value;
    _checkFormValidation();
  }

  TextEditingController weightTextController = TextEditingController();

  final Rxn<DateTime> _datetimeSelected = Rxn<DateTime>();
  DateTime? get datetimeSelected => _datetimeSelected.value;
  set datetimeSelected(DateTime? value) {
    _datetimeSelected.value = value;
    _checkFormValidation();
  }

  int get totalWeight {
    String strVal = weightTextController.text.trim().toNumericText;
    return int.tryParse(strVal) ?? 0;
  }

  @override
  void onInit() {
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
    _recordProductHttp = Get.find<RecordProductHttpService>();
    super.onInit();
  }

  void _checkFormValidation() {
    if (totalWeight > 0 &&
        unitSelected.isNotEmpty() &&
        filesPathSelected.isNotEmpty &&
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

  String? totalWeightValidation(String? value) {
    if (value != null && totalWeight <= 0) {
      if (value.isEmpty) {
        return S.current.totalWeightIsRequired;
      }
      return S.current.totalWeightInvalid;
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

  RecordProductRequest _getRecordProductPayload() {
    return RecordProductRequest(
      totalWeight: totalWeight.toDouble(),
      weightUnit: unitSelected.value,
      recordedAt:
          (datetimeSelected ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000,
      uploadProofs: filesPathSelected,
    );
  }

  Future<void> _savePendingRecordProduct(RecordProductRequest payload) async {
    PendingRequestModel pending = PendingRequestModel.pending(
      payload.toJson(),
      RequestType.recordByProduct,
    );
    await _pendingRequestCache.init();
    await _pendingRequestCache.repo.put(pending.id, pending);
  }

  Future<String> saveRecordProduct() async {
    RecordProductRequest payload = _getRecordProductPayload();
    final processingDialog = ProcessingDialog.show();
    final result = await _recordProductHttp.logRecordByProduct(payload);
    processingDialog.hide();
    if (result.isSuccess()) {
      return S.current.dataSaved;
    }
    if (OfflineHttpStatus.pendingStatus.contains(result.statusCode)) {
      _savePendingRecordProduct(payload);
      return S.current.noInternetSubmitData;
    }
    SnackBars.error(
      message: result.getErrorMessage(),
    ).show(duration: 5000);
    return "";
  }
}
