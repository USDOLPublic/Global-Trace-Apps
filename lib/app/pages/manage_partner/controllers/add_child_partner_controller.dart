import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class AddChildPartnerController extends GetxController {
  late final UserModel userInfo;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late PartnerArgument partnerArgument;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController facilityController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode facilityNameNode = FocusNode();
  FocusNode addressFocus = FocusNode();

  final _enableNextButton = false.obs;
  bool get enableNextButton => _enableNextButton.value;
  set enableNextButton(bool value) => _enableNextButton.value = value;

  final RxList<FacilityRespModel> _facilities = <FacilityRespModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<FacilityRespModel> get facilities => _facilities.value;
  set facilities(List<FacilityRespModel> value) => _facilities.value = value;

  final Rxn<FacilityRespModel> _facilitySelected = Rxn<FacilityRespModel>();
  FacilityRespModel? get facilitySelected => _facilitySelected.value;
  set facilitySelected(FacilityRespModel? value) =>
      _facilitySelected.value = value;

  final Rxn<InputItem> _typeSelected = Rxn<InputItem>();
  InputItem? get typeSelected => _typeSelected.value;
  set typeSelected(InputItem? value) => _typeSelected.value = value;

  final RxList<InputItem> _typesPartner = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get typesPartner => _typesPartner.value;
  set typesPartner(List<InputItem> value) => _typesPartner.value = value;

  StreamSubscription? _invitePermissionStream;
  String _keyFacility = '';
  final List<String> _invitePermissionTypes = <String>[];

  final LocationInputController locationInputController =
      LocationInputController();

  late final InvitePartnerService _invitePartnerService;
  late final InvitePartnerPermissionCacheService _invitePermissionCache;

  @override
  void onInit() {
    userInfo = MainController.to.userInfo;
    _invitePartnerService = Get.find<InvitePartnerService>();
    _invitePermissionCache = Get.find<InvitePartnerPermissionCacheService>();
    facilityNameNode.addListener(() {
      facilityController.text = facilityController.text.trim();
    });

    if (Get.arguments != null && Get.arguments is PartnerArgument) {
      partnerArgument = Get.arguments as PartnerArgument;
    }

    super.onInit();
  }

  @override
  void onReady() {
    _fetchInvitePermission();
    super.onReady();
  }

  @override
  void onClose() async {
    await _invitePermissionStream?.cancel();
    super.onClose();
  }

  void _fetchInvitePermission() async {
    await _invitePermissionCache.init();
    _invitePermissionStream =
        _invitePermissionCache.repo.dataStream.listen((data) {
      typesPartner.clear();
      _invitePermissionTypes.clear();
      if (data.isNotEmpty) {
        data.forEach((String key, InvitePartnerPermission value) {
          String typeName = value.name ?? '';
          typesPartner.add(
            InputItem(value: typeName, displayLabel: typeName, code: value.id),
          );
          _invitePermissionTypes.add(typeName);
        });
      }
      _typesPartner.refresh();
    });
    StaticResourceHelper().cacheInvitePartnerPermission(_invitePartnerService);
  }

  void checkFormValidation() {
    if (facilitySelected != null) {
      enableNextButton = true;
      return;
    }

    final locationChecked = locationInputController.isValid();
    if (enableNextButton &&
        (!isFormValidate || typeSelected == null || !locationChecked)) {
      enableNextButton = false;
      return;
    } else if (!enableNextButton &&
        (isFormValidate && typeSelected != null && locationChecked)) {
      enableNextButton = true;
    }
  }

  bool get isFormValidate {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final name = businessNameController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        (name.isEmpty)) {
      return false;
    } else {
      return formKey.currentState?.validate() ?? false;
    }
  }

  Future<String?> onTapButtonAdd() async {
    if (isFormValidate || facilitySelected != null) {
      final province = locationInputController.provinceSelected?.value;
      final district = locationInputController.districtSelected?.value;
      var req = InvitePartnerReq(
        userInformation: UserInformationReq(
          email: emailController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phoneNumber: phoneController.text.trim(),
        ),
        partnerInformation: PartnerInformation(
          businessName: businessNameController.text.trim(),
          districtId: district,
          provinceId: province,
          countryId: locationInputController.countrySelected?.value,
          roleId: typeSelected?.code,
        ),
      );

      if (facilitySelected != null) {
        req.facilityId = facilitySelected!.id;
      }
      return AddPartnerController.to.addChildPartner(req);
    } else {
      return null;
    }
  }

  Future<List<FacilityRespModel>> loadListFacility(String key) async {
    if (key.isNotEmpty &&
        ((key.trim().isEmpty) || _keyFacility == key.trim())) {
      return facilities;
    }

    facilities.clear();
    _keyFacility = key.trim();

    var resp = await _invitePartnerService.searchFacilities(
      _keyFacility,
      InvitePartnerType.childBroker,
    );
    if (resp.isSuccess() && resp.data != null) {
      facilities = resp.data ?? [];
    } else {
      facilities = [];
    }
    return facilities;
  }

  Future<void> chooseFacility(FacilityRespModel facility) async {
    String typeName = facility.type ?? '';
    typesPartner = [
      InputItem(
        displayLabel: typeName,
        value: typeName,
        code: facility.typeId,
      )
    ];
    typeSelected = typesPartner
        .firstWhereOrNull((element) => element.value == facility.type);

    final FacilityUser userInfo = (facility.users?.length ?? 0) >= 1
        ? facility.users![0]
        : FacilityUser(id: "");
    facilitySelected = facility;
    facilityController.text = facility.name ?? '';
    businessNameController.text = facility.name ?? '';

    firstNameController.text = userInfo.firstName ?? '';
    lastNameController.text = userInfo.lastName ?? '';
    emailController.text = userInfo.email ?? '';
    phoneController.text = userInfo.phoneNumber ?? '';
    if (facility.type == PartnerRoleName.nonFarm) {
      businessNameController.text = nonFarmTitle;
      locationInputController.setSelect(
        countryId: partnerArgument.country,
        provinceId: partnerArgument.province,
        districtId: partnerArgument.district,
      );
    } else {
      locationInputController.setSelect(
        countryId: facility.country?.id,
        provinceId: facility.province?.id,
        districtId: facility.district?.id,
      );
    }
  }

  void clearFacility() {
    facilitySelected = null;
    facilityController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    businessNameController.clear();
    typeSelected = null;
    locationInputController.refresh();
  }
}
