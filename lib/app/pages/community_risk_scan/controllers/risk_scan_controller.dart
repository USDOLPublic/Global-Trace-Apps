import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:usdol/app/core.dart';

class RiskScanController extends GetxController {
  late final RiskScanHttpService _riskScanHttp;
  late final PendingRequestCacheService _pendingRequestCache;
  late final ManagePartnerCacheService _managePartnerCache;
  late final RiskScanScheduleSending _riskScanSchedule;

  final _enableSaveButton = false.obs;
  bool get enableSaveButton => _enableSaveButton.value;
  set enableSaveButton(bool value) => _enableSaveButton.value = value;

  final _useMyLocation = false.obs;
  bool get useMyLocation => _useMyLocation.value;
  set useMyLocation(bool value) => _useMyLocation.value = value;
  String _myAddressDetected = "";

  final _locationDetecting = false.obs;
  bool get locationDetecting => _locationDetecting.value;
  set locationDetecting(bool value) => _locationDetecting.value = value;

  final Rxn<DateTime> _datetimeSelected = Rxn<DateTime>();
  DateTime? get datetimeSelected => _datetimeSelected.value;
  set datetimeSelected(DateTime? value) {
    _datetimeSelected.value = value;
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

  final RxList<FacilityRespModel> _facilities = <FacilityRespModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<FacilityRespModel> get facilities => _facilities.value;
  set facilities(List<FacilityRespModel> value) => _facilities.value = value;

  final Rxn<FacilityRespModel> _facilitySelected = Rxn<FacilityRespModel>();
  FacilityRespModel? get facilitySelected => _facilitySelected.value;
  set facilitySelected(FacilityRespModel? value) =>
      _facilitySelected.value = value;

  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController locationTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  TextEditingController facilityTextController = TextEditingController();
  TextEditingController auditNumberTextController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode noteFocus = FocusNode();
  FocusNode facilityNameNode = FocusNode();
  String _keyFacility = '';
  List<FacilityRespModel> _originFacilitiesCached = <FacilityRespModel>[];

  final _filesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathSelected => _filesPathSelected.value;
  set filesPathSelected(List<String> value) => _filesPathSelected.value = value;

  List<LaborRisksModel>? listLaborRisks;

  final RxnString _numIndicatorAdded = RxnString();
  String? get numIndicatorAdded => _numIndicatorAdded.value;
  set numIndicatorAdded(String? value) => _numIndicatorAdded.value = value;

  String get location {
    if (useMyLocation) {
      return _myAddressDetected;
    } else {
      return locationTextController.text.trim();
    }
  }

  String get notes {
    return noteTextController.text.trim();
  }

  String? get auditNumber {
    return auditNumberTextController.text.trim();
  }

  String get facility {
    return facilityTextController.text.trim();
  }

  @override
  void onInit() {
    _riskScanHttp = Get.find<RiskScanHttpService>();
    _riskScanSchedule = RiskScanScheduleSending(
      fileHttpService: Get.find<FileHttpService>(),
      riskScanHttpService: _riskScanHttp,
    );
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
    _managePartnerCache = Get.find<ManagePartnerCacheService>();
    facilityNameNode.addListener(() {
      facilityTextController.text = facilityTextController.text.trim();
    });
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

  void _checkFormValidation() {
    if (facilitySelected != null &&
        location.isNotEmpty &&
        notes.isNotEmpty &&
        prioritySelected.isNotEmpty() &&
        datetimeSelected != null &&
        listLaborRisks != null &&
        listLaborRisks!.isNotEmpty &&
        (formGlobalKey.currentState?.validate() ?? false)) {
      enableSaveButton = true;
    } else {
      enableSaveButton = false;
    }
  }

  void formInputOnChange() {
    _checkFormValidation();
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

  RiskScanRequest _getRiskScanPayload() {
    return RiskScanRequest(
      facilityId: facilitySelected?.id ?? '',
      location: location,
      recordedAt: datetimeSelected ?? DateTime.now(),
      priority: int.parse(prioritySelected.value),
      laborRisks: listLaborRisks ?? [],
      message: notes,
      auditReportNumber: auditNumber,
      uploadFiles: filesPathSelected,
    );
  }

  Future<void> _savePendingRiskScan(RiskScanRequest payload) async {
    PendingRequestModel pending = PendingRequestModel.pending(
      payload.toJson(),
      RequestType.community,
    );
    await _pendingRequestCache.init();
    await _pendingRequestCache.repo.put(pending.id, pending);
  }

  Future<String> submitRiskScan() async {
    RiskScanRequest riskScanReq = _getRiskScanPayload();

    var progress = ProcessingDialog.show();
    final response = await _riskScanSchedule.sendRiskScanRequest(riskScanReq);
    progress.hide();
    if (response.isSuccess()) {
      return S.current.dataSaved;
    }
    if (OfflineHttpStatus.pendingStatus.contains(response.statusCode)) {
      _savePendingRiskScan(riskScanReq);
      return S.current.noInternetSubmitData;
    }
    String errorMessage = response.getErrorMessage();
    SnackBars.error(message: errorMessage).show(duration: 5000);
    return '';
  }

  Future<List<FacilityRespModel>> loadListFacility(String key) async {
    if (key.isNotEmpty &&
        ((key.trim().isEmpty) || _keyFacility == key.trim())) {
      return facilities;
    }

    facilities.clear();
    _keyFacility = key.trim();
    bool isConnected = await NetworkUtil.isConnected();
    if (isConnected) {
      var resp = await _riskScanHttp.searchFacility(_keyFacility);
      if (resp.isSuccess() && resp.data != null) {
        facilities = resp.data ?? [];
        return facilities;
      }
    }
    facilities = await _searchFacilityInCache(key);
    return facilities;
  }

  Future<List<FacilityRespModel>> _searchFacilityInCache(String key) async {
    List<FacilityRespModel> resultFacilities = <FacilityRespModel>[];
    //load facilities
    if (_originFacilitiesCached.isEmpty) {
      await _managePartnerCache.init();
      Map<String, FacilityRespModel> mapData =
          _managePartnerCache.repository.getAllValues();
      if (mapData.isNotEmpty) {
        _originFacilitiesCached = mapData.values.toList();
      }
    }
    if (_originFacilitiesCached.isNotEmpty) {
      //filter
      resultFacilities = _originFacilitiesCached.where((element) {
        if ((element.name?.contains(key) ?? false)) {
          return true;
        }
        if ((element.farmGroupId?.contains(key) ?? false)) {
          return true;
        }
        if ((element.farmId?.contains(key) ?? false)) {
          return true;
        }
        if (element.farmGroupId != null && element.farmId != null) {
          String farmPattern =
              "${element.farmGroupId ?? ""}-${element.farmId ?? ""}";
          if (farmPattern.contains(key)) {
            return true;
          }
        }
        return false;
      }).toList();
      //sort
      resultFacilities.sort((a, b) {
        if (a.name == null || a.name!.isEmpty) {
          return 1;
        }
        if (b.name == null || b.name!.isEmpty) {
          return -1;
        }
        return (a.name ?? '').trim().compareTo((b.name ?? '').trim());
      });
    } else {
      resultFacilities = [];
    }
    return resultFacilities;
  }

  Future<void> chooseFacility(FacilityRespModel facility) async {
    useMyLocation = false;
    facilitySelected = facility;
    facilityTextController.text = facility.name ?? '';
    locationTextController.clear();
    List<String> addressInfo = [];

    if (facility.address?.isNotEmpty ?? false) {
      addressInfo.add(facility.address!);
    }
    if (facility.district != null) {
      addressInfo.add(facility.districtDisplayName);
    }
    if (facility.province != null) {
      addressInfo.add(facility.provinceDisplayName);
    }
    if (facility.country != null) {
      addressInfo.add(facility.countryDisplayName);
    }

    locationTextController.text = addressInfo.join(", ");
    _checkFormValidation();
  }

  Future<bool> detectMyLocation(BuildContext context) async {
    locationDetecting = true;
    Position? myPosition;
    //Check permission
    bool isAllowed = await GeolocatorUtil.isAllowedPermission(
      context,
      isEnableGotoAppSetting: true,
    );
    if (isAllowed) {
      //Get current geolocator
      myPosition = await GeolocatorUtil.getLastKnowPosition(
        context,
        isEnableGotoAppSetting: true,
      );
      if (myPosition != null) {
        //Get address information
        _myAddressDetected = await GeolocatorUtil.getAddressInfo(
          context,
          latLng: myPosition,
        );
        locationTextController.text = _myAddressDetected;
        useMyLocation = true;
      } else {
        SnackBars.error(message: S.current.detectLocationFail)
            .show(duration: 5000);
      }
    }
    _checkFormValidation();
    locationDetecting = false;
    return myPosition != null;
  }

  void addIndicators(List<LaborRisksModel> laborRisks) {
    listLaborRisks = List.from(laborRisks);
    _checkFormValidation();
  }

  bool isHaveIndicatorAdded() {
    return listLaborRisks != null && listLaborRisks!.isNotEmpty;
  }
}
