import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class RespondToRequestController extends GetxController {
  late final RequestInformationHttpService _httpService;
  late final PendingRequestCacheService _pendingRequestCache;
  late final RequestInformationScheduleSending _requestInfoScheduleSending;

  final formGlobalKey = GlobalKey<FormState>();

  final Rxn<DateTime> _dateTime = Rxn<DateTime>();
  DateTime? get dateTime => _dateTime.value;
  set dateTime(DateTime? value) {
    _dateTime.value = value;
    _checkFormValidation();
  }

  final RxList<InputItem> _priority = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get priorities => _priority.value;
  set priorities(List<InputItem> value) => _priority.value = value;

  final _prioritySelected = InputItem.empty().obs;
  InputItem get prioritySelected => _prioritySelected.value;
  set prioritySelected(InputItem value) {
    _prioritySelected.value = value;
    _checkFormValidation();
  }

  final Rxn<InputItem> _indicatorSelected = Rxn<InputItem>();
  InputItem? get indicatorSelected => _indicatorSelected.value;
  set indicatorSelected(InputItem? value) {
    _indicatorSelected.value = value;
    _checkFormValidation();
  }

  final Rxn<InputItem> _severitySelected = Rxn<InputItem>();
  InputItem? get severitySelected => _severitySelected.value;
  set severitySelected(InputItem? value) {
    _severitySelected.value = value;
    _checkFormValidation();
  }

  TextEditingController noteTextController = TextEditingController();
  TextEditingController auditNumberTextController = TextEditingController();

  final _filesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathSelected => _filesPathSelected.value;
  set filesPathSelected(List<String> value) => _filesPathSelected.value = value;

  final RxList<InputItem> _indicators = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get indicators => _indicators.value;
  set indicators(List<InputItem> value) => _indicators.value = value;

  final RxList<InputItem> _severities = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get severities => _severities.value;
  set severities(List<InputItem> value) => _severities.value = value;

  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  RequestInformationModel? requestInfo;
  DetailRequestController? _detailRequestController;

  final RxnString _numIndicatorAdded = RxnString();
  String? get numIndicatorAdded => _numIndicatorAdded.value;
  set numIndicatorAdded(String? value) => _numIndicatorAdded.value = value;

  List<LaborRisksModel>? listLaborRisks;

  @override
  void onInit() {
    _httpService = Get.find<RequestInformationHttpService>();
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
    _requestInfoScheduleSending = RequestInformationScheduleSending(
      fileHttpService: Get.find<FileHttpService>(),
      requestInfoHttpService: _httpService,
    );
    if (Get.arguments != null && Get.arguments is RequestInformationModel) {
      RequestInformationModel arguments =
          Get.arguments as RequestInformationModel;
      requestInfo = arguments;
    }
    if (Get.isRegistered<DetailRequestController>()) {
      _detailRequestController = Get.find<DetailRequestController>();
    }
    _loadData();
    super.onInit();
  }

  Future<void> _loadData() async {
    priorities.clear();
    for (var item in listPriorityDef) {
      priorities.add(
        InputItem(
          value: item.value.toString(),
          displayLabel: item.value.toString(),
        ),
      );
    }
    _priority.refresh();
  }

  void pickFile(String path) {
    filesPathSelected.add(path);
    _filesPathSelected.refresh();
    _checkFormValidation();
  }

  void removeFile(String path) {
    filesPathSelected.removeWhere((element) => element == path);
    _filesPathSelected.refresh();
    _checkFormValidation();
  }

  RespondModel _getRespondPayload() {
    return RespondModel(
      id: const Uuid().v1(),
      grievanceReportId: requestInfo?.id,
      priority: int.tryParse(prioritySelected.value),
      laborRisks: listLaborRisks?.map((e) {
            return LaborRisksResp(
              indicatorId: e.indicator?.id,
              indicator: e.indicator,
              subIndicatorId: e.subIndicator?.id,
              subIndicator: e.subIndicator,
              severity: e.severity?.value,
            );
          }).toList() ??
          [],
      message: noteTextController.text.trim(),
      auditReportNumber: auditNumberTextController.text.trim(),
      uploadImages: filesPathSelected.isEmpty ? null : filesPathSelected,
      recordedAt: (dateTime ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000,
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  Future<void> _savePendingRespond(RespondModel payload) async {
    PendingRequestModel pending = PendingRequestModel.pending(
      payload.toJson(),
      RequestType.requestInformation,
    );
    await _pendingRequestCache.init();
    await _pendingRequestCache.repo.put(pending.id, pending);
  }

  Future<String> onSubmit() async {
    final RespondModel respondPayload = _getRespondPayload();
    var progress = ProcessingDialog.show();
    final resp = await _requestInfoScheduleSending.sendRespondRequest(
      payload: respondPayload,
      reportId: requestInfo?.id ?? '',
    );
    progress.hide();
    if (resp.isSuccess()) {
      _detailRequestController?.addRespond(respondPayload);
      return S.current.responseSubmitted;
    }
    if (OfflineHttpStatus.pendingStatus.contains(resp.statusCode)) {
      _detailRequestController?.addRespond(respondPayload);
      _savePendingRespond(respondPayload);
      return S.current.noInternetSubmitData;
    }
    String errorMessage = resp.getErrorMessage();
    SnackBars.error(message: errorMessage).show(duration: 5000);
    return '';
  }

  void formInputOnChange() {
    _checkFormValidation();
  }

  void _checkFormValidation() {
    if (prioritySelected.isNotEmpty() &&
        dateTime != null &&
        noteTextController.text.trim().isNotEmpty &&
        listLaborRisks != null &&
        listLaborRisks!.isNotEmpty &&
        (formGlobalKey.currentState?.validate() ?? false)) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }

  void addIndicators(List<LaborRisksModel> laborRisks) {
    listLaborRisks = List.from(laborRisks);
    _checkFormValidation();
  }
}
