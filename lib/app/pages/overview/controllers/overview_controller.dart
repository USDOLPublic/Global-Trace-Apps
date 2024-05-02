import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:usdol/app/core.dart';

class OverviewController extends GetxController {
  OverviewController({this.isFullOverview = true});
  final bool isFullOverview;

  final Rx<DateRangeModel> _timeFilterRange = DateRangeModel().obs;
  DateRangeModel get timeFilterRange => _timeFilterRange.value;
  set timeFilterRange(DateRangeModel value) => _timeFilterRange.value = value;

  final Rxn<CalculationChartResp> _productTradeChart =
      Rxn<CalculationChartResp>();
  CalculationChartResp? get productTradeChart => _productTradeChart.value;
  set productTradeChart(CalculationChartResp? value) =>
      _productTradeChart.value = value;

  final Rxn<MassBalanceChartResp> _massBalanceChart =
      Rxn<MassBalanceChartResp>();
  MassBalanceChartResp? get calMassBalanceChart => _massBalanceChart.value;
  set calMassBalanceChart(MassBalanceChartResp? value) =>
      _massBalanceChart.value = value;

  final Rxn<MarginErrorChartResp> _calMarginErrorChart =
      Rxn<MarginErrorChartResp>();
  MarginErrorChartResp? get calMarginErrorChart => _calMarginErrorChart.value;
  set calMarginErrorChart(MarginErrorChartResp? value) =>
      _calMarginErrorChart.value = value;

  final _isHistorySyncing = false.obs;
  bool get isHistorySyncing => _isHistorySyncing.value;
  set isHistorySyncing(bool value) => _isHistorySyncing.value = value;

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  late final UserModel userInfo;
  late final OverviewHttpService _overviewHttpService;
  ProductBackgroundHandler? _productBackgroundHandler;

  HistoryController? historyController;
  StreamSubscription? _startSyncStream;
  StreamSubscription? _endSyncStream;

  @override
  void onInit() {
    userInfo = MainController.to.userInfo;
    _overviewHttpService = Get.find<OverviewHttpService>();
    if (Get.isRegistered<ProductBackgroundHandler>() && isFullOverview) {
      _productBackgroundHandler = Get.find<ProductBackgroundHandler>();
      _startSyncStream = _productBackgroundHandler?.syncStartStream.listen(
        (isAutoTrigger) {
          isHistorySyncing = true;
        },
      );
      _endSyncStream = _productBackgroundHandler?.syncStream.listen(
        _onSyncCompleted,
      );
      isHistorySyncing = _productBackgroundHandler!.isSyncing;
    }
    super.onInit();
  }

  @override
  void onReady() {
    initFilter();
    calculationCharts();
    LogUtil.d("Overview Controller On Ready!");
    super.onReady();
  }

  @override
  void onClose() {
    _startSyncStream?.cancel();
    _endSyncStream?.cancel();
    super.onClose();
  }

  void initFilter() {
    SeasonTimeModel? seasonTime = StaticResourceHelper().getSeasonStartTime();
    if (seasonTime != null) {
      List<DateRangeModel> listCircleDay =
          seasonTime.getListCircleDays(userInfo.isMassBalance());
      if (listCircleDay.isNotEmpty) {
        timeFilterRange = DateRangeModel(
          start: listCircleDay.first.start,
          end: listCircleDay.first.end,
        );
      }
    }
  }

  ChartFilterReq get _chartFilter => ChartFilterReq(
        from: timeFilterRange.start,
        to: timeFilterRange.end?.endOfDay,
      );

  Future<void> calculateMassBalanceChart() async {
    if (userInfo.isMassBalance()) {
      var resp = await _overviewHttpService.massBalanceChart(_chartFilter);
      if (resp.isSuccess() && resp.data != null) {
        calMassBalanceChart = resp.data!;
      }
    }
  }

  Future<void> calculateProductChart() async {
    var resp = await _overviewHttpService.calculationChart(_chartFilter);
    if (resp.isSuccess() && resp.data != null) {
      productTradeChart = resp.data!;
    }
  }

  Future<void> calculateMarginErrorChart() async {
    if (isHasPermissionViewErrorMargin()) {
      var resp = await _overviewHttpService.marginErrorChart(_chartFilter);
      if (resp.isSuccess() && resp.data != null) {
        calMarginErrorChart = resp.data!;
      }
    } else {
      calMarginErrorChart = null;
    }
  }

  bool isHasPermissionViewErrorMargin() {
    return userInfo.hasPermission(PermissionActionDef.viewMarginOfError);
  }

  bool isHavePermissionViewHistory() {
    return userInfo.hasPermission(PermissionActionDef.viewHistory);
  }

  Future<void> calculationCharts() async {
    await Future.wait([
      calculateMassBalanceChart(),
      calculateProductChart(),
      calculateMarginErrorChart(),
    ]);
  }

  void filterOnUpdate(DateRangeModel result) {
    timeFilterRange = result;
    calculationCharts();
    historyController?.changeHistoryTimeRange(timeFilterRange);
  }

  void initHistory(HistoryController? controller) {
    historyController = controller;
    historyController?.onLoadComplete = () => refreshController.loadComplete();
    historyController?.onLoadNoData = () => refreshController.loadNoData();
    historyController?.onResetNoData = () => refreshController.resetNoData();
  }

  Future<void> loadMoreHistory() async {
    await historyController?.loadMoreHistory();
  }

  Future<void> syncPendingRequest() async {
    if (isHistorySyncing) {
      return;
    }
    await _productBackgroundHandler?.submitPendingData(
      isAutoTrigger: false,
    );
  }

  void _onSyncCompleted(SyncResponse syncRes) async {
    LogUtil.d("Overview completed sync pending data!");
    if (!syncRes.isAutoTrigger ||
        syncRes.status == SyncStatus.completed ||
        syncRes.status == SyncStatus.completedWithDataSubmitted) {
      List<Future<void>> fetchDataTasks = [calculationCharts()];
      if (historyController != null) {
        fetchDataTasks.add(historyController!.syncHistory());
      }
      await Future.wait<void>(fetchDataTasks);
    }
    isHistorySyncing = false;
  }
}
