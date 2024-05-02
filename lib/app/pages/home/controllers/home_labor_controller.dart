import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:usdol/app/core.dart';

class HomeLaborController extends HomeController {
  late final LaborOfflineCacheManager _offlineCache;
  late final LaborBackgroundHandler _backgroundHandler;

  StreamSubscription? _subInternetConnection;

  @override
  void onInit() {
    super.onInit();
    _offlineCache = Get.find<LaborOfflineCacheManager>();
    _backgroundHandler = Get.find<LaborBackgroundHandler>();
    createTutorial(false);
  }

  @override
  void onReady() {
    _offlineCache.cacheData();
    _registerInternetOnChange();
    super.onReady();
  }

  @override
  void onClose() async {
    _subInternetConnection?.cancel();
    super.onClose();
  }

  void _registerInternetOnChange() {
    _subInternetConnection = NetworkUtil.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        LogUtil.d("Connectivity change to offline");
      } else {
        LogUtil.d("Connectivity change to online");
        _backgroundHandler.submitPendingData();
      }
    });
  }

  bool _hasPermission(String permissionName) {
    return userInfo.hasPermission(permissionName);
  }

  bool hasViewReport() {
    return _hasPermission(PermissionActionDef.viewReports);
  }

  bool hasCommunityRiskScanSubmit() {
    return _hasPermission(PermissionActionDef.submitReports) &&
        _hasPermission(PermissionActionDef.proactiveAssessments);
  }
}
