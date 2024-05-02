import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class RegisterOarIdController extends GetxController {
  late GlobalKey<FormState> formKey;

  TextEditingController businessController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final FocusNode addressNode = FocusNode();

  final _enableRequestButton = false.obs;
  bool get enableRequestButton => _enableRequestButton.value;
  set enableRequestButton(bool value) => _enableRequestButton.value = value;

  final _enableRequestForm = true.obs;
  bool get enableRequestForm => _enableRequestForm.value;
  set enableRequestForm(bool value) => _enableRequestForm.value = value;

  final Rxn<SearchOarIdRespModel> _searchOarIdResp =
      Rxn<SearchOarIdRespModel>();
  SearchOarIdRespModel? get searchOarIdResp => _searchOarIdResp.value;
  set searchOarIdResp(SearchOarIdRespModel? value) =>
      _searchOarIdResp.value = value;

  final Rxn<OarIdResult> _oarIdSelected = Rxn<OarIdResult>();
  OarIdResult? get oarIdSelected => _oarIdSelected.value;
  set oarIdSelected(OarIdResult? value) => _oarIdSelected.value = value;

  final _isConfirmingOarID = false.obs;
  bool get isConfirmingOarID => _isConfirmingOarID.value;
  set isConfirmingOarID(bool value) => _isConfirmingOarID.value = value;

  final LocationInputController locationInputController =
      LocationInputController();

  late final ProfileHttpService _profileHttpService;
  StreamSubscription? _subPurchasePartner;

  OarIdReqModel? oarIdReq;

  @override
  void onInit() {
    _profileHttpService = Get.find<ProfileHttpService>();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() async {
    await _subPurchasePartner?.cancel();
    super.onClose();
  }

  void checkFormValidation() {
    if (enableRequestButton && !isFormValidate) {
      enableRequestButton = false;
    } else if (!enableRequestButton && isFormValidate) {
      enableRequestButton = true;
    }
  }

  bool get isFormValidate {
    final business = businessController.text.trim();
    final address = addressController.text.trim();

    if (business.isEmpty || address.isEmpty) {
      return false;
    }

    if (!locationInputController.isValid()) {
      return false;
    }

    return formKey.currentState?.validate() ?? false;
  }

  Future<void> searchOarId() async {
    var processingDialog = ProcessingDialog.show();
    oarIdSelected = null;
    searchOarIdResp = null;
    var countrySelected = locationInputController.countrySelected;
    var provinceSelected = locationInputController.provinceSelected;
    var districtSelected = locationInputController.districtSelected;
    oarIdReq = OarIdReqModel(
      countryName: countrySelected?.displayLabel,
      provinceName: provinceSelected?.displayLabel,
      districtName: districtSelected?.displayLabel,
      countryId: countrySelected?.value,
      provinceId: provinceSelected?.value,
      districtId: districtSelected?.value,
      address: addressController.text.trim(),
      name: businessController.text.trim(),
    );

    final resp = await _profileHttpService.searchOarId(oarIdReq!);
    processingDialog.hide();
    if (resp.isSuccess() && resp.data != null) {
      searchOarIdResp = resp.data;
      //form enable/disable
      if (searchOarIdResp!.isErrorData) {
        enableRequestForm = true;
      } else {
        enableRequestForm = false;
      }
      //check for new facility
      if (searchOarIdResp!.isNewFacility) {
        oarIdSelected = searchOarIdResp!.getOarIdResultFromRequest(oarIdReq!);
        isConfirmingOarID = true;
      } else if (searchOarIdResp!.matches?.isNotEmpty ?? false) {
        if (searchOarIdResp!.isMatched) {
          oarIdSelected = searchOarIdResp!.getMatchedOarId().first;
        } else {
          oarIdSelected = searchOarIdResp?.matches?.first;
        }
      }
      //hide keyboard
      KeyboardUtils.forceHideKeyboard(Get.context!);
    } else {
      String errorMessage = resp.getErrorMessage();
      SnackBars.error(message: errorMessage).show(duration: 5000);
    }
  }

  Future<void> onTapButtonDone() async {
    if (oarIdSelected == null || searchOarIdResp == null) return;
    //1) Register new
    if (searchOarIdResp!.isNewFacility) {
      Get.back<OarIdResult>(result: oarIdSelected);
      return;
    }

    //2) Matched
    if (searchOarIdResp!.isMatched) {
      if (oarIdSelected!.isOtherOption()) {
        //reset form when user select a not me.
        Get.back<OarIdResult>(result: OarIdResult(inputNewInfo: true));
      } else {
        //Back to profile with oar id selected.
        Get.back<OarIdResult>(result: oarIdSelected);
      }
      return;
    }

    //3) Potential
    if (searchOarIdResp!.isPotential) {
      //User selected not me. and register a new oar-id using information input
      //Back to profile with oar id register.
      if (isConfirmingOarID && oarIdSelected != null) {
        Get.back<OarIdResult>(result: oarIdSelected);
        return;
      }
      //Check option selected
      OarIdResult? oarIdConfirmed;
      if (oarIdSelected!.isOtherOption()) {
        oarIdConfirmed =
            await _registerOarIDBySuppliedInfo(searchOarIdResp?.matches ?? []);
      } else {
        oarIdConfirmed =
            await _confirmOarID(oarIdSelected!.facilityMatchId!.toString());
      }
      //have error happened when confirm oar-id
      if (oarIdConfirmed == null) {
        SnackBars.error(message: S.current.bussinessInformationInValid).show();
        return;
      }
      //Check and handle when have a new data from server
      if (oarIdSelected!.isOtherOption()) {
        // Protential and selected not me. will switch to wait for confirm
        oarIdSelected = oarIdConfirmed;
        searchOarIdResp?.matches ??= [];
        searchOarIdResp!.matches = [oarIdSelected!];
        isConfirmingOarID = true;
      } else {
        // Back to main in case
        Get.back<OarIdResult>(result: oarIdConfirmed);
      }
    }
  }

  Future<OarIdResult?> _registerOarIDBySuppliedInfo(
      List<OarIdResult>? rejectOarIds) async {
    if (rejectOarIds == null) null;
    var processingDialog = ProcessingDialog.show();
    List<String> oarIds =
        rejectOarIds!.map((e) => (e.facilityMatchId ?? "").toString()).toList();
    oarIds.removeWhere((element) => element.isEmpty);
    var result = await _profileHttpService.rejectOarId(oarIds);
    processingDialog.hide();
    if (result.isSuccess()) {
      return result.data;
    } else {
      String errorMessage = result.getErrorMessage();
      SnackBars.error(message: errorMessage).show(duration: 5000);
      return null;
    }
  }

  Future<OarIdResult?> _confirmOarID(String facilityMatchId) async {
    var processingDialog = ProcessingDialog.show();
    var result = await _profileHttpService.confirmOarId(facilityMatchId);
    processingDialog.hide();
    if (result.isSuccess()) {
      return result.data;
    } else {
      String errorMessage = result.getErrorMessage();
      SnackBars.error(message: errorMessage).show(duration: 5000);
      return null;
    }
  }

  void resetOarIdRequestForm() async {
    searchOarIdResp = null;
    oarIdSelected = null;
    enableRequestForm = true;
    businessController.clear();
    addressController.clear();
    locationInputController.reset();
    checkFormValidation();
  }
}
