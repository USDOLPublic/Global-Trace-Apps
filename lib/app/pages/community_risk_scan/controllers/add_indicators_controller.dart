import 'package:usdol/app/core.dart';

class AddIndicatorController extends GetxController {
  late final IndicatorCacheService _indicatorCacheService;

  final _enableAddButton = false.obs;
  bool get enableAddButton => _enableAddButton.value;
  set enableAddButton(bool value) => _enableAddButton.value = value;

  final RxList<InputItem> _indicator = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get indicators => _indicator.value;
  set indicators(List<InputItem> value) => _indicator.value = value;

  final RxList<InputItem> _subIndicator = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get subIndicators => _subIndicator.value;
  set subIndicators(List<InputItem> value) => _subIndicator.value = value;

  final RxList<InputItem> _severity = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get severities => _severity.value;
  set severities(List<InputItem> value) => _severity.value = value;

  bool editLaborRisk = false;

  final _indicatorSelected = InputItem.empty().obs;
  InputItem get indicatorSelected => _indicatorSelected.value;
  set indicatorSelected(InputItem value) {
    _indicatorSelected.value = value;
    _checkFormValidation();
  }

  final _subIndicatorSelected = InputItem.empty().obs;
  InputItem get subIndicatorSelected => _subIndicatorSelected.value;
  set subIndicatorSelected(InputItem value) {
    _subIndicatorSelected.value = value;
    _checkFormValidation();
  }

  final _severitySelected = InputItem.empty().obs;
  InputItem get severitySelected => _severitySelected.value;
  set severitySelected(InputItem value) {
    _severitySelected.value = value;
    _checkFormValidation();
  }

  List<IndicatorModel> indicatorsData = [];

  final Rx<List<LaborRisksModel>> _laborRisks = Rx<List<LaborRisksModel>>([]);
  List<LaborRisksModel> get laborRisks => _laborRisks.value;
  set laborRisks(List<LaborRisksModel> value) => _laborRisks.value = value;

  @override
  void onInit() {
    _indicatorCacheService = Get.find<IndicatorCacheService>();
    _loadData();
    if (Get.arguments != null && Get.arguments is List<LaborRisksModel>) {
      List<LaborRisksModel> listLaborRisks =
          Get.arguments as List<LaborRisksModel>;
      editLaborRisk = true;
      getListLaborRisk(listLaborRisks);
    }
    super.onInit();
  }

  void getListLaborRisk(List<LaborRisksModel> listLaborRisks) {
    laborRisks = List.from(listLaborRisks);
    _laborRisks.refresh();
  }

  Future<void> _loadData() async {
    await _indicatorCacheService.init();
    indicatorsData = _indicatorCacheService.repo.getListValue();
    indicators.clear();
    for (var item in indicatorsData) {
      indicators.addIf(
        item.type == indicatorType,
        InputItem(
          value: item.id ?? "",
          displayLabel: item.name ?? "",
        ),
      );
    }
    _indicator.refresh();

    severities.clear();
    for (var item in listSeverityDef) {
      severities.add(
        InputItem(
          value: item.id,
          displayLabel: item.name ?? "",
        ),
      );
    }
    _severity.refresh();
  }

  Future<void> loadDataSubIndicator() async {
    List<IndicatorModel> subIndicatorsData = indicatorsData
        .where((element) =>
            element.parentId == indicatorSelected.value &&
            // ignore: unrelated_type_equality_checks
            element.type == subIndicatorType)
        .toList();
    subIndicators.clear();
    for (var item in subIndicatorsData) {
      subIndicators.add(
        InputItem(
          value: item.id ?? "",
          displayLabel: item.name ?? "",
        ),
      );
    }
    _subIndicator.refresh();
  }

  void _checkFormValidation() {
    if (indicatorSelected.isNotEmpty() &&
        subIndicatorSelected.isNotEmpty() &&
        severitySelected.isNotEmpty()) {
      LaborRisksModel laborRisksModel = createIndicator();
      if (!checkExistedIndicator(laborRisksModel)) {
        enableAddButton = true;
      } else {
        enableAddButton = false;
      }
    } else {
      enableAddButton = false;
    }
  }

  LaborRisksModel createIndicator() {
    IndicatorModel indicator = indicatorsData
        .firstWhere((element) => element.id == indicatorSelected.value);
    IndicatorModel subIndicator = indicatorsData
        .firstWhere((element) => element.id == subIndicatorSelected.value);
    SeverityModel severity = listSeverityDef
        .firstWhere((element) => element.id == severitySelected.value);
    LaborRisksModel laborRisksModel = LaborRisksModel(
      indicator: indicator,
      subIndicator: subIndicator,
      severity: severity,
      id: const Uuid().v1(),
    );
    return laborRisksModel;
  }
  bool checkExistedIndicator(LaborRisksModel laborRisksModel) {
    LaborRisksModel? checkExist = laborRisks.firstWhereOrNull((element) =>
        element.indicator?.id == laborRisksModel.indicator?.id &&
        element.subIndicator?.id == laborRisksModel.subIndicator?.id);
    if (checkExist != null) {
      return true;
    } else {
      return false;
    }
  }

  void addLaborRisk() {
    LaborRisksModel laborRisksModel = createIndicator();
    if (!checkExistedIndicator(laborRisksModel)) {
      laborRisks.insert(0, laborRisksModel);
      _laborRisks.refresh();
      _resetAddLaborRisk();
    }
  }

  void _resetAddLaborRisk() {
    indicatorSelected = InputItem.empty();
    subIndicators.clear();
    _subIndicator.refresh();
    subIndicatorSelected = InputItem.empty();
    severitySelected = InputItem.empty();
  }

  void deleteLaborRisk(String id) {
    if (laborRisks.isNotEmpty) {
      laborRisks.removeWhere((element) => element.id == id);
      _laborRisks.refresh();
    }
  }

  void doneAddLaborRisk() {
    Get.back(result: laborRisks);
  }
}
