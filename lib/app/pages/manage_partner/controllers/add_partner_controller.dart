import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class AddPartnerController extends GetxController {
  static AddPartnerController get to => Get.find<AddPartnerController>();

  late final UserModel userInfo;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController facilityController = TextEditingController();
  final TextEditingController businessRegisterController =
      TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode facilityNameNode = FocusNode();
  FocusNode addressFocus = FocusNode();

  final _enableNextButton = false.obs;
  bool get enableNextButton => _enableNextButton.value;
  set enableNextButton(bool value) => _enableNextButton.value = value;

  final _enableAddBusinessPartner = true.obs;
  bool get enableAddBusinessPartner => _enableAddBusinessPartner.value;
  set enableAddBusinessPartner(bool value) =>
      _enableAddBusinessPartner.value = value;

  final RxList<FacilityRespModel> _facilities = <FacilityRespModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<FacilityRespModel> get facilities => _facilities.value;
  set facilities(List<FacilityRespModel> value) => _facilities.value = value;

  final RxList<InvitePartnerReq> _childPartner = <InvitePartnerReq>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InvitePartnerReq> get childPartner => _childPartner.value;
  set childPartner(List<InvitePartnerReq> value) => _childPartner.value = value;

  final Rxn<FacilityRespModel> _facilitySelected = Rxn<FacilityRespModel>();
  FacilityRespModel? get facilitySelected => _facilitySelected.value;
  set facilitySelected(FacilityRespModel? value) =>
      _facilitySelected.value = value;

  final RxList<InputItem> _typesPartner = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get typesPartner => _typesPartner.value;
  set typesPartner(List<InputItem> value) => _typesPartner.value = value;

  final Rxn<InputItem> _typeSelected = Rxn<InputItem>();
  InputItem? get typeSelected => _typeSelected.value;
  set typeSelected(InputItem? value) => _typeSelected.value = value;

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late PartnerArgument partnerArgument;
  InvitePartnerType get inviteType => partnerArgument.type;

  StreamSubscription? _invitePermissionStream;
  String _keyFacility = '';

  late final InvitePartnerService _invitePartnerService;

  final LocationInputController locationInputController = LocationInputController();

  @override
  void onInit() {
    userInfo = MainController.to.userInfo;
    _invitePartnerService = Get.find<InvitePartnerService>();
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
    _invitePermissionStream =
        StaticResourceHelper().invitePartnerPermissionStream.listen((data) {
      typesPartner.clear();
      if (data.isNotEmpty) {
        data.forEach((String key, InvitePartnerPermission value) {
          String typeName = value.name ?? '';
          typesPartner.add(
            InputItem(value: typeName, displayLabel: typeName, code: value.id),
          );
        });
      }
      _typesPartner.refresh();
    });
    StaticResourceHelper().cacheInvitePartnerPermission(_invitePartnerService);
  }

  void checkFormValidation() {
    if (isFormValidate && !enableNextButton) {
      enableNextButton = true;
    } else if (!isFormValidate && enableNextButton) {
      enableNextButton = false;
    }
  }

  bool get isFormValidate {
    if (inviteType == InvitePartnerType.broker && childPartner.isEmpty) {
      return false;
    }
    if (inviteType == InvitePartnerType.processing && typeSelected == null) {
      return false;
    }
    if (facilitySelected != null) {
      return true;
    }
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final name = businessNameController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        name.isEmpty ||
        !(formKey.currentState?.validate() ?? false)) {
      return false;
    }

    final isLocationValid = locationInputController.isValid();
    if (!isLocationValid && inviteType != InvitePartnerType.processing) {
      return false;
    }
    return true;
  }

  InvitePartnerReq _getDataForInviteRequest() {
    UserInformationReq userInformation = UserInformationReq(
      email: emailController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      phoneNumber: phoneController.text.trim() == ''
          ? null
          : phoneController.text.trim(),
    );
    InvitePartnerReq req = InvitePartnerReq(
      userInformation: userInformation,
    );
    if (facilitySelected != null) {
      req.facilityId = facilitySelected!.id;
    }
    final province = locationInputController.provinceSelected?.value;
    final district = locationInputController.districtSelected?.value;
    switch (inviteType) {
      case InvitePartnerType.broker:
        String regId = businessRegisterController.text.trim();

        ///
        ///Filter Only add child partner is add new
        List<InvitePartnerReq> newPartners =
            childPartner.where((element) => element.isEnableEdit).toList();
        final broker = BrokerInformation(
          businessName: businessNameController.text.trim(),
          address: addressController.text.trim() == ''
              ? null
              : addressController.text.trim(),
          districtId: district,
          provinceId: province,
          countryId: locationInputController.countrySelected?.value,
          businessRegisterNumber: regId == '' ? null : regId,
        );
        req.brokerInformation = broker;
        req.partners = newPartners;
        break;
      case InvitePartnerType.processing:
        final facility = FacilityInformation(
          businessName: businessNameController.text.trim() == ''
              ? null
              : businessNameController.text.trim(),
          roleId: typeSelected?.code,
        );
        req.facilityInformation = facility;
        break;
      case InvitePartnerType.transporter:
        String regId = businessRegisterController.text.trim();
        final transporter = TransporterInformation(
          businessName: businessNameController.text.trim(),
          address: addressController.text.trim() == ''
              ? null
              : addressController.text.trim(),
          districtId: district,
          provinceId: province,
          countryId: locationInputController.countrySelected?.value,
          businessRegisterNumber: regId == '' ? null : regId,
        );
        req.transporterInformation = transporter;
        break;
      default:
        break;
    }
    return req;
  }

  Future<bool> onTapButtonAdd() async {
    var process = ProcessingDialog.show();
    InvitePartnerReq requestData = _getDataForInviteRequest();
    var res = await _invitePartnerService.addPartner(
      requestData,
      inviteType,
    );
    process.hide();
    if (!res.isSuccess()) {
      String errorMessage = res.getErrorMessage();
      SnackBars.error(message: errorMessage).show(duration: 5000);
    }

    return res.isSuccess();
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
      inviteType,
    );
    if (resp.isSuccess() && resp.data != null) {
      facilities = resp.data ?? [];
    } else {
      facilities = [];
    }
    return facilities;
  }

  Future<void> chooseFacility(FacilityRespModel facility) async {
    final FacilityUser userModel = (facility.users?.length ?? 0) >= 1
        ? facility.users![0]
        : FacilityUser(id: "");
    facilitySelected = facility;
    facilityController.text = facility.name ?? '';
    firstNameController.text = userModel.firstName ?? '';
    lastNameController.text = userModel.lastName ?? '';
    emailController.text = userModel.email ?? '';
    phoneController.text = userModel.phoneNumber ?? '';
    businessNameController.text = facility.name ?? '';
    businessRegisterController.text = facility.businessRegisterNumber ?? '';

    locationInputController.setSelect(
      countryId: facility.country?.id,
      provinceId: facility.province?.id,
      districtId: facility.district?.id,
    );

    addressController.text = facility.address ?? '';
    if (inviteType == InvitePartnerType.broker) {
      childPartner.clear();
      var processing = ProcessingDialog.show();
      List<InvitePartnerReq>? partnerRefList =
          await _getChildPartnerRefer(facilitySelected?.id);
      processing.hide();
      if (partnerRefList != null && partnerRefList.isNotEmpty) {
        childPartner.addAll(partnerRefList);
        enableAddBusinessPartner = false;
      } else {
        enableAddBusinessPartner = true;
      }
      _childPartner.refresh();
    } else if (inviteType == InvitePartnerType.processing) {
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
    }
    checkFormValidation();
  }

  void clearFacility() {
    facilitySelected = null;
    facilityController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    businessNameController.clear();
    businessRegisterController.clear();
    locationInputController.reset();
    addressController.clear();
    childPartner.clear();
    _childPartner.refresh();
  }

  String? addChildPartner(InvitePartnerReq child) {
    final bool childExits = childPartner.firstWhereOrNull((element) {
          if (child.facilityId != null) {
            return child.facilityId == element.facilityId;
          }
          if (element.userInformation?.email == null) {
            return false;
          }
          return element.userInformation?.email == child.userInformation?.email;
        }) !=
        null;
    if (childExits) {
      return S.current.childPartnerHadExits;
    } else {
      childPartner.add(child);
      checkFormValidation();
      _childPartner.refresh();
      return null;
    }
  }

  void deleteChildPartner(InvitePartnerReq partner) {
    if (partner.facilityId != null && partner.facilityId!.isNotEmpty) {
      childPartner.removeWhere(
          (InvitePartnerReq it) => it.facilityId == partner.facilityId);
    } else {
      childPartner.removeWhere((InvitePartnerReq it) {
        return (it.facilityId == null || it.facilityId!.isEmpty) &&
            it.userInformation?.email == partner.userInformation?.email;
      });
    }
    checkFormValidation();
    _childPartner.refresh();
  }

  Future<List<InvitePartnerReq>?> _getChildPartnerRefer(
      String? partnerId) async {
    if (partnerId == null || partnerId.isEmpty) {
      return null;
    }
    var resp = await _invitePartnerService.getChildReferFacilities(partnerId);
    if (resp.isSuccess() && resp.data != null) {
      List<FacilityRespModel> childFacilities = resp.data!;
      List<InvitePartnerReq> childInvitedList = <InvitePartnerReq>[];
      for (FacilityRespModel child in childFacilities) {
        FacilityUser? childUser =
            (child.users?.isNotEmpty ?? false) ? child.users?.first : null;
        String? provinceId = child.country?.id == otherCountry.id
            ? otherProvince.id
            : child.province?.id;
        String? districtId = child.country?.id == otherCountry.id
            ? otherDistricts.id
            : child.district?.id;
        InvitePartnerReq childInvited = InvitePartnerReq(
          userInformation: UserInformationReq(
            email: childUser?.email,
            firstName: childUser?.firstName,
            lastName: childUser?.lastName,
            phoneNumber: childUser?.phoneNumber,
          ),
          facilityId: child.id,
          isEnableEdit: false,
          partnerInformation: PartnerInformation(
            businessName: child.name,
            districtId: districtId,
            provinceId: provinceId,
            countryId: child.country?.id,
          ),
        );
        childInvitedList.add(childInvited);
      }
      return childInvitedList;
    }
    return null;
  }
}
