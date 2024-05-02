import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:usdol/app/core.dart';

class EditProfileController extends GetxController {
  late final UserModel userInfo;
  late final EditProfileType type;
  late final String pageTitle;

  late final ProfileHttpService _profileHttpService;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController registerNumberController =
      TextEditingController();
  final TextEditingController oarIdController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode emailNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode oarIdNode = FocusNode();

  final Rxn<InputItem> _certificationSelected = Rxn<InputItem>();
  InputItem? get certificationSelected => _certificationSelected.value;
  set certificationSelected(InputItem? value) =>
      _certificationSelected.value = value;

  final Rxn<InputItem> _chainSelected = Rxn<InputItem>();
  InputItem? get chainSelected => _chainSelected.value;
  set chainSelected(InputItem? value) => _chainSelected.value = value;

  final Rxn<InputItem> _durationSelected = Rxn<InputItem>();
  InputItem? get durationSelected => _durationSelected.value;
  set durationSelected(InputItem? value) => _durationSelected.value = value;

  final Rxn<DateTime> _reconciliationDateTime = Rxn<DateTime>();
  DateTime? get reconciliationDateTime => _reconciliationDateTime.value;
  set reconciliationDateTime(DateTime? value) =>
      _reconciliationDateTime.value = value;

  final _profile = UserModel(id: '').obs;
  UserModel get profile => _profile.value;
  set profile(UserModel value) => _profile.value = value;

  final _enableNextButton = false.obs;
  bool get enableNextButton => _enableNextButton.value;
  set enableNextButton(bool value) => _enableNextButton.value = value;

  final _isMassBalanceProfile = false.obs;
  bool get isMassBalanceProfile => _isMassBalanceProfile.value;
  set isMassBalanceProfile(bool value) => _isMassBalanceProfile.value = value;

  late GlobalKey<FormState> formKey;

  final Rx<CheckOarIdType> _checkOarIdType = CheckOarIdType.none.obs;
  CheckOarIdType get checkOarIdType => _checkOarIdType.value;
  set checkOarIdType(CheckOarIdType value) => _checkOarIdType.value = value;

  final RxList<InputItem> _commodities = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get commodities => _commodities.value;
  set commodities(List<InputItem> value) => _commodities.value = value;

  final RxList<InputItem> _goodsSelected = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get goodsSelected => _goodsSelected.value;
  set goodsSelected(List<InputItem> value) => _goodsSelected.value = value;

  final LocationInputController locationInputController =
      LocationInputController();

  EditProfileArguments? _arguments;
  StreamSubscription? _subPurchasePartner;
  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 1000));

  @override
  void onInit() {
    userInfo = MainController.to.userInfo;
    formKey = GlobalKey<FormState>();
    _profileHttpService = Get.find<ProfileHttpService>();
    emailNode.addListener(() {
      emailController.text = emailController.text.trim();
    });
    if (Get.arguments != null && Get.arguments is EditProfileArguments) {
      EditProfileArguments arguments = Get.arguments as EditProfileArguments;
      _arguments = arguments;
      type = arguments.type;
      pageTitle = arguments.pageTitle;
    } else {
      type = EditProfileType.fromProfile;
      pageTitle = S.current.edit;
    }
    super.onInit();
  }

  @override
  void onReady() {
    _setUpData();
    super.onReady();
  }

  @override
  void onClose() async {
    await _subPurchasePartner?.cancel();
    super.onClose();
  }

  Future<void> _setUpData() async {
    if (_arguments?.profile != null) {
      profile = _arguments!.profile!;
      final FacilityModel? facility = profile.currentFacility;
      //update input values
      firstNameController.text = profile.firstName ?? '';
      lastNameController.text = profile.lastName ?? '';
      emailController.text = profile.email ?? '';
      phoneController.text = profile.phoneNumber ?? '';
      nameController.text = facility?.name ?? '';
      currentPasswordController.text = S.current.dot;
      String businessId = "";
      if (facility?.businessRegisterNumber != null &&
          facility!.businessRegisterNumber!.isNotEmpty) {
        businessId = (facility.businessRegisterNumber ?? '');
      }
      registerNumberController.text = businessId;
      //oar
      String oarId = (facility?.oarId ?? '');
      oarIdController.text = oarId;
      //address
      addressController.text = facility?.address ?? '';
      if (type == EditProfileType.fromProfile && oarId.isNotEmpty) {
        checkOarIdType = CheckOarIdType.skip;
      }
      //certification
      certificationSelected = profileCertificationsDef
          .firstWhereOrNull((cer) => cer.value == facility?.certification);
      //chainOfCustody
      chainSelected = chainOfCustodyDef.firstWhereOrNull(
          (chain) => chain.value == profile.getChainOfCustody());
      //mass balance
      if (chainSelected?.value == massBalanceDef.value) {
        isMassBalanceProfile = true;
        if (facility?.reconciliationStartAt != null) {
          reconciliationDateTime =
              DateUtil.fromSeconds(facility?.reconciliationStartAt);
        }
      }
      String? reconciliationDuration = facility?.reconciliationDurationValue;
      durationSelected = reconciliationDurationsDef.firstWhereOrNull(
          (duration) => duration.value == reconciliationDuration);
      //country, district, province
      _setupLocationData(facility);
      //Goods
      List<String> goodData = facility?.goods ?? [];
      goodsSelected = goodData
          .map(
            (e) => InputItem(displayLabel: e, value: e),
          )
          .toList();
      _goodsSelected.refresh();
    }
    List<String> commoditiesData =
        Prefs.getListString(Defines.commoditiesDataKey);
    commodities = commoditiesData
        .map((e) => InputItem(displayLabel: e, value: e))
        .toList();
    _commodities.refresh();
  }

  void _setupLocationData(FacilityModel? facility) {
    locationInputController.setSelect(
      countryId: facility?.countryId,
      provinceId: facility?.provinceId,
      districtId: facility?.districtId,
      isSkipValidate: true,
    );
  }

  bool get _isFormValid {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final registerNumber = registerNumberController.text.trim();
    final address = addressController.text.trim();
    final oarId = oarIdController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        name.isEmpty ||
        address.isEmpty ||
        !(formKey.currentState?.validate() ?? false) ||
        !_isLocationValid) {
      return false;
    }
    if (userInfo.isProductUser() &&
        (registerNumber.isEmpty || oarId.isEmpty || !_isCertificationValid)) {
      return false;
    }
    return true;
  }

  bool get _isLocationValid => locationInputController.isValid();

  bool get _isCertificationValid {
    if (userInfo.isLaborUser()) {
      return true;
    }

    if (certificationSelected == null) {
      return false;
    }

    if (isMassBalanceProfile && durationSelected == null) {
      return false;
    }

    if (isMassBalanceProfile && reconciliationDateTime == null) {
      return false;
    }
    return true;
  }

  void checkFormValidation() {
    enableNextButton = _isFormValid;
  }

  Future<void> onTapButtonNext() async {
    if (enableNextButton) {
      String regId = registerNumberController.text.trim();
      String oarId = oarIdController.text.trim();
      var process = ProcessingDialog.show();
      final country = locationInputController.countrySelected?.value;
      final province = locationInputController.provinceSelected?.value;
      final district = locationInputController.districtSelected?.value;
      final businessRegisterNumber = regId.isEmpty ? null : regId;
      final ProfileRequestModel profileRequest = ProfileRequestModel(
        user: User(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
        ),
        facility: FacilityReq(
          businessRegisterNumber: businessRegisterNumber,
          oarId: oarId.isEmpty ? null : oarId,
          certification: certificationSelected?.value,
          name: nameController.text.trim(),
          address: addressController.text.trim(),
          districtId: district,
          provinceId: province,
          countryId: country,
          chainOfCustody: chainSelected?.value,
          reconciliationDuration: durationSelected?.value,
          reconciliationStartAt: reconciliationDateTime,
          goods: type == EditProfileType.fromProfile
              ? null
              : goodsSelected.map((e) => e.value).toList(),
        ),
      );
      final resp = await _profileHttpService.updateProfile(req: profileRequest);
      process.hide();

      if (resp.isSuccess()) {
        Get.back<bool>(result: true);
      } else {
        String errorMessage = resp.getErrorMessage();
        SnackBars.error(message: errorMessage).show(duration: 5000);
      }
    }
  }

  void checkChainDetail() {
    isMassBalanceProfile = chainSelected?.value == massBalanceDef.value;
  }

  Future<void> checkFacilitiesOarId(String oarId) async {
    checkOarIdType = CheckOarIdType.checking;
    final CheckOarIdRequestModel reqModel =
        CheckOarIdRequestModel(oarId: oarId);
    final resp = await _profileHttpService.facilitiesCheckOarID(reqModel);
    if (resp.isSuccess() &&
        resp.data != null &&
        (resp.data!.isMatched ?? false)) {
      OarIDRespModel oar = resp.data!;
      await updateOarIdValidated(
        OarIdResult(
          name: oar.name,
          address: oar.address,
          oarId: oarId,
          countryName: oar.countryDisplayName,
          countryCode: oar.countryCode,
          countryId: oar.countryId,
          provinceId: oar.provinceId,
          districtId: oar.districtId,
          country: CountryModel(
            id: oar.countryId,
            country: oar.countryDisplayName,
          ),
          province: ProvinceModel(
            id: oar.provinceId,
            province: oar.provinceDisplayName,
          ),
          district: DistrictModel(
            id: oar.districtId,
            district: oar.districtDisplayName,
          ),
        ),
      );
    } else {
      resetOarId();
      checkOarIdType = CheckOarIdType.fail;
      oarIdNode.requestFocus();
    }
  }

  Future<void> updateOarIdValidated(OarIdResult oar) async {
    checkOarIdType = CheckOarIdType.success;
    oarIdController.text = oar.oarId ?? "";
    oarIdController.text = oar.oarId ?? "";
    nameController.text = oar.name ?? '';
    addressController.text = oar.address ?? '';
    locationInputController.setSelect(
      countryId: oar.country?.id,
      provinceId: oar.provinceId,
      districtId: oar.district?.id,
      isSkipValidate: true,
    );
    checkFormValidation();
  }

  void resetOarId() {
    nameController.clear();
    addressController.clear();
    locationInputController.reset();
  }
}
