import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:usdol/app/core.dart';

class HomeProductController extends HomeController {
  final int _numOfPage = 2;
  final int _numOfLastTrade = 2;
  late final HistoryHttpService _historyHttp;
  late final OverviewController overviewController;
  late final HistoryCacheService _historyCache;
  late final ProductOfflineCacheManager _offlineCacheManager;
  late final ProductBackgroundHandler _backgroundHandler;

  final _isShowCycleChart = true.obs;
  bool get isShowCycleChart => _isShowCycleChart.value;
  set isShowCycleChart(bool value) => _isShowCycleChart.value = value;

  final _histories = <HistoryModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<HistoryModel> get histories => _histories.value;
  set histories(List<HistoryModel> value) => _histories.value = value;

  final Rxn<DateTime> _lastUpdate = Rxn<DateTime>();
  DateTime? get lastUpdate => _lastUpdate.value;
  set lastUpdate(DateTime? value) => _lastUpdate.value = value;

  StreamSubscription? _subHistory;
  StreamSubscription? _subInternetConnection;
  StreamSubscription? _backgroundSync;

  @override
  void onInit() {
    super.onInit();
    _historyHttp = Get.find<HistoryHttpService>();
    _historyCache = Get.find<HistoryCacheService>();
    _offlineCacheManager = Get.find<ProductOfflineCacheManager>();
    _backgroundHandler = Get.find<ProductBackgroundHandler>();
    _backgroundSync = _backgroundHandler.syncStream.listen(
      (event) {
        if (event.status == SyncStatus.completedWithDataSubmitted) {
          transactionOnUpdate();
        }
      },
    );
    overviewController = Get.find<OverviewController>(tag: 'home');
    userInfo = MainController.to.userInfo;
    onUserInfoChanged = _onUpdateUserInfo;
    isShowCycleChart = userInfo.isMassBalance();
    createTutorial(false);
    _initHistories();
    _offlineCacheManager.cacheData();
    _registerInternetOnChange();
  }

  @override
  void onClose() async {
    await _subHistory?.cancel();
    await _subInternetConnection?.cancel();
    await _backgroundSync?.cancel();
    super.onClose();
  }

  Future<void> _initHistories() async {
    await _historyCache.init();
    _subHistory =
        _historyCache.repo.dataStream.listen((Map<String, HistoryModel> event) {
      if (event.isNotEmpty) {
        List<HistoryModel> allHistories = event.values.toList();
        allHistories =
            allHistories.where((element) => element.isTradeType()).toList();
        if (allHistories.isNotEmpty) {
          allHistories.sort((a, b) => (b.getTradeDate() ?? DateTime.now())
              .compareTo(a.getTradeDate() ?? DateTime.now()));
        }
        histories.assignAll(allHistories.take(_numOfLastTrade));
        _histories.refresh();
      }
    });
    //update history from server
    await _updateHistories();
  }

  Future<void> _updateHistories() async {
    var res = await _historyHttp.getHistories(
      HistoryReq(
        page: 1,
        perPage: _numOfPage,
        toTime: DateTime.now(),
        types: [
          TransactionType.purchase.toString(),
          TransactionType.sale.toString()
        ],
      ),
    );
    if (res.isSuccess() && res.data != null && res.data!.items != null) {
      List<HistoryModel> hisData = res.data!.items!;
      await _historyCache.repo.putAndUpdate(hisData);
    }
  }

  void _onUpdateUserInfo(UserModel user) {
    userInfo = user;
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

  void transactionOnUpdate() {
    _updateHistories();
    overviewController.calculateMassBalanceChart();
  }

  bool hasPermission(String permissionName) {
    return userInfo.hasPermission(permissionName);
  }
}
