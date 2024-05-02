import 'dart:async';

import 'package:usdol/app/core.dart';

class ProfileController extends GetxController {
  final _profile = UserModel(id: '').obs;
  UserModel get profile => _profile.value;
  set profile(UserModel value) => _profile.value = value;

  final _address = ''.obs;

  String get address => _address.value;

  set address(String value) => _address.value = value;

  final _startDate = ''.obs;

  String get startDate => _startDate.value;

  set startDate(String value) => _startDate.value = value;

  late final ProfileHttpService _profileHttpService;
  late final UserCacheService _userCacheService;
  late final SessionManager _sessionManager;
  late final AuthHttpService _authHttpService;

  StreamSubscription? _subPurchasePartner;

  @override
  void onInit() {
    _profileHttpService = Get.find<ProfileHttpService>();
    _userCacheService = Get.find<UserCacheService>();
    _sessionManager = Get.find<SessionManager>();
    _authHttpService = Get.find<AuthHttpService>();
    super.onInit();
  }

  @override
  void onReady() {
    _subPurchasePartner = _userCacheService.userRepo.dataStream
        .listen((Map<String, UserModel> event) {
      if (event.isNotEmpty) {
        profile = event.values.toList().first;
        _setUpProfile();
      }
    });

    super.onReady();
  }

  @override
  void onClose() async {
    await _subPurchasePartner?.cancel();
    super.onClose();
  }

  void onTapEditProfile() async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.editProfile,
      arguments: EditProfileArguments(
        type: EditProfileType.fromProfile,
        pageTitle: S.current.edit,
        profile: profile,
      ),
    );
    if (result != null && result is bool) {
      SnackBars.complete(message: S.current.profileSuccessfully)
          .show(duration: 5000);
      fetchProfile();
    }
  }

  Future<void> fetchProfile() async {
    bool isConnected = await NetworkUtil.isConnected();
    if (isConnected) {
      final res = await _profileHttpService.loadProfile();
      if (res.isSuccess() && res.data != null) {
        UserModel? user = res.data;
        bool isUserValid = _isUserValidated(user);
        if (isUserValid) {
          if (user != null) {
            await _userCacheService.userRepo.put(user.id, user);
          }
        } else {
          SnackBars.error(message: S.current.notSupportBusiness)
              .show(duration: 5000);
        }
      } else {
        SnackBars.error(message: S.current.genericErrorDescriptionShort).show();
      }
    }
  }

  void _setUpProfile() {
    if (profile.currentFacility != null) {
      FacilityModel facility = profile.currentFacility!;
      address = facility.getFullAddress();
      final startDateTime = DateTime.fromMillisecondsSinceEpoch(
          (facility.reconciliationStartAt ?? 0) * 1000);
      startDate = DateUtil.formatDate(startDateTime,
          format: AppProperties.dateFormatDefault);
    }
  }

  bool _isUserValidated(UserModel? user) {
    if (user != null) {
      return user.isMobileSupported();
    } else {
      return false;
    }
  }

  Future<void> deleteAccount() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final deleteResult = await _profileHttpService.deleteMyAccount();

    if (deleteResult.isSuccess()) {
      await _sessionManager.cleanSession();
      await _authHttpService.logout();
      processingDialog.hide();
      Get.back<void>();
      Get.offNamed<void>(Routes.login);
    } else {
      processingDialog.hide();
      String errorMsg = deleteResult.getErrorMessage(
        defaultErrMessage: S.current.genericErrorDescriptionShort,
      );
      SnackBars.error(message: errorMsg).show();
    }
  }
}
