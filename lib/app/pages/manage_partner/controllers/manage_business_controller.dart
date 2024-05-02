import 'dart:async';

import 'package:usdol/app/core.dart';

class ManageBusinessController extends GetxController {
  static ManageBusinessController get to =>
      Get.find<ManageBusinessController>();

  bool isFromOnboardScreen = false;

  final _enableNextButton = false.obs;

  bool get enableNextButton => _enableNextButton.value;

  set enableNextButton(bool value) => _enableNextButton.value = value;

  late final InvitePartnerService _invitePartnerService;

  final RxList<ManagePartnerModel> _partners = <ManagePartnerModel>[].obs;

  // ignore: invalid_use_of_protected_member
  List<ManagePartnerModel> get partners => _partners.value;

  set partners(List<ManagePartnerModel> value) => _partners.value = value;

  final List<FacilityRespModel> _businessPartners = [];

  StreamSubscription? _subPurchasePartner;
  late final ManagePartnerCacheService _managePartnerCacheService;
  late final ManagePartnerRepository _partnerRepository;

  @override
  void onInit() {
    _invitePartnerService = Get.find<InvitePartnerService>();
    _managePartnerCacheService = Get.find<ManagePartnerCacheService>();
    _partnerRepository = _managePartnerCacheService.repository;
    if (Get.arguments != null && Get.arguments is bool) {
      isFromOnboardScreen = Get.arguments as bool;
    }

    partners = [
      ManagePartnerModel(
        argument: PartnerArgument(
          type: InvitePartnerType.broker,
          name: S.current.broker,
          suggestHint: S.current.brokerName,
          hasChildPartner: true,
          registerTitle: S.current.registerBroker,
        ),
        businessPartners: [],
      ),
      ManagePartnerModel(
        argument: PartnerArgument(
          type: InvitePartnerType.processing,
          name: S.current.processingFacility,
          suggestHint: S.current.searchProcessingFacilityHint,
          hasChildPartner: false,
          registerTitle: S.current.registerProcessingFacility,
        ),
        businessPartners: [],
      ),
      ManagePartnerModel(
        argument: PartnerArgument(
          type: InvitePartnerType.transporter,
          name: S.current.transporter,
          suggestHint: S.current.transporterName,
          hasChildPartner: false,
          registerTitle: S.current.registerTransporter,
        ),
        businessPartners: [],
      ),
    ];

    super.onInit();
  }

  @override
  void onClose() async {
    await _subPurchasePartner?.cancel();
    super.onClose();
  }

  @override
  void onReady() {
    _loadBusinessPartnerLocal();
    super.onReady();
  }

  void checkEnableNextButton() {
    bool enable = false;
    for (ManagePartnerModel manage in partners) {
      if (manage.businessPartners?.isNotEmpty ?? false) {
        enable = true;
      }
    }
    enableNextButton = enable;
  }

  Future<void> _loadBusinessPartnerLocal() async {
    await _managePartnerCacheService.init();
    _subPurchasePartner = _partnerRepository.dataStream
        .listen((Map<String, FacilityRespModel> event) {
      _businessPartners.clear();
      if (event.isNotEmpty) {
        for (FacilityRespModel businessPartner in event.values.toList()) {
          _businessPartners.add(businessPartner);
        }
      }
      partners[0].businessPartners = _businessPartners
          .where((element) => (element.type ?? "") == PartnerRoleName.broker)
          .toList();
      partners[1].businessPartners = _businessPartners
          .where((element) =>
              (element.type ?? "") != PartnerRoleName.broker &&
              (element.type ?? "") != PartnerRoleName.transporter)
          .toList();
      partners[2].businessPartners = _businessPartners
          .where(
              (element) => (element.type ?? "") == PartnerRoleName.transporter)
          .toList();
      _partners.refresh();
      checkEnableNextButton();
    });

    fetchBusinessPartner();
  }

  Future<void> fetchBusinessPartner() async {
    bool isConnected = await NetworkUtil.isConnected();
    if (isConnected) {
      final resp = await _invitePartnerService.getBusinessPartners();
      if (resp.isSuccess()) {
        Map<String, FacilityRespModel> mapData = <String, FacilityRespModel>{};
        if (resp.data != null) {
          for (var e in resp.data!) {
            mapData[e.id ?? ''] = e;
          }
        }
        await _partnerRepository.assignAll(mapData);
      } else {
        SnackBars.error(
            message: resp.getErrorMessage(
          defaultErrMessage: S.current.genericErrorDescriptionShort,
        )).show(duration: 5000);
      }
    } else {
      SnackBars.error(message: S.current.unableToConnectToServer)
          .show(duration: 5000);
    }
  }

  void addPartner(FacilityRespModel partner) async {
    _partnerRepository.putAllAndUpdateExisting(
      {partner.id ?? '': partner},
      (key, oldValue, newValue) => newValue,
    );
  }

  Future<void> deletePartner(FacilityRespModel partner) async {
    bool isConnected = await NetworkUtil.isConnected();
    if (isConnected) {
      var process = ProcessingDialog.show();
      final resp = await _invitePartnerService.deletePartner(partner.id ?? '');
      process.hide();
      if (resp.isSuccess()) {
        SnackBars.complete(message: S.current.partnerHasBeenRemoved).show();
        _partnerRepository.deleteKeys([partner.id ?? '']);
      } else {
        String errorMessage = resp.getErrorMessage();
        SnackBars.error(message: errorMessage).show();
      }
    } else {
      SnackBars.error(message: S.current.unableToConnectToServer)
          .show(duration: 5000);
    }
  }

  Future<void> updateCacheData() async {
    //
    // Re-cache partner use transaction in offline mode
    // Cache partners for ginner
    if (Get.isRegistered<ProductOfflineCacheManager>()) {
      Get.find<ProductOfflineCacheManager>().cachePartners();
    }
  }
}
