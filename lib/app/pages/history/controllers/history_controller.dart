import 'dart:async';
import 'package:usdol/app/core.dart';

class HistoryController extends GetxController {
  late final HistoryHttpService _historyHttp;
  late final FileHttpService _fileHttp;
  late final HistoryCacheService _historyCache;
  late final PendingRequestCacheService _pendingRequestCache;
  late final UserModel _userInfo;

  int _currentPage = 1;
  final int _pageSize = 20;

  final _histories = <HistoryModel>[].obs;
  // ignore: invalid_use_of_protected_member
  List<HistoryModel> get histories => _histories.value;
  set histories(List<HistoryModel> value) => _histories.value = value;

  DateRangeModel? _timeFilterRange;

  void Function()? onLoadComplete;
  void Function()? onLoadNoData;
  void Function()? onResetNoData;

  @override
  void onInit() {
    _historyHttp = Get.find<HistoryHttpService>();
    _fileHttp = Get.find<FileHttpService>();
    _historyCache = Get.find<HistoryCacheService>();
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
    _currentPage = 1;
    _userInfo = MainController.to.userInfo;
    super.onInit();
  }

  @override
  void onReady() {
    _initMassBalanceFilter();
    _initHistories();
    super.onReady();
  }

  Future<void> _initHistories() async {
    await _historyCache.init();
    await _loadHistory(_currentPage);
    await _loadPendingRequest(_getReqFilter(_currentPage));
  }

  void _initMassBalanceFilter() {
    SeasonTimeModel? seasonTime = StaticResourceHelper().getSeasonStartTime();
    if (seasonTime != null) {
      List<DateRangeModel> listCircleDay =
          seasonTime.getListCircleDays(_userInfo.isMassBalance());
      if (listCircleDay.isNotEmpty) {
        _timeFilterRange = DateRangeModel(
          start: listCircleDay.first.start,
          end: listCircleDay.first.end,
        );
      }
    }
  }

  bool isUsingCycleDateRange() {
    return _userInfo.isMassBalance();
  }

  Future<void> syncHistory() async {
    _currentPage = 1;
    onResetNoData?.call();
    await _loadHistory(_currentPage, isShowLoading: false);
    await _loadPendingRequest(_getReqFilter(_currentPage));
  }

  Future<void> changeHistoryTimeRange(DateRangeModel timeFilter) async {
    _timeFilterRange = timeFilter;
    _currentPage = 1;
    onResetNoData?.call();
    await _loadHistory(_currentPage);
    await _loadPendingRequest(_getReqFilter(_currentPage));
  }

  Future<void> loadMoreHistory() async {
    await _loadHistory(_currentPage);
  }

  HistoryReq _getReqFilter(int page) {
    HistoryReq reqData = HistoryReq(
      page: page,
      perPage: _pageSize,
      toTime: DateTime.now().endOfDay,
    );

    if (_timeFilterRange != null && _timeFilterRange!.isNotEmpty()) {
      reqData.fromTime = _timeFilterRange!.start!;
      reqData.toTime = _timeFilterRange!.end!.endOfDay;
    }
    return reqData;
  }

  Future<void> _loadHistoryFromCache(int page, HistoryReq reqData) async {
    //get from cache
    var hisByDateRangeData = _historyCache.repo.getAllItemByDateRange(reqData);
    if (hisByDateRangeData.isNotEmpty) {
      var hisByPage =
          _historyCache.repo.getPageItemByHis(reqData, hisByDateRangeData);
      if (page > 1) {
        histories.addAll(hisByPage);
        onLoadComplete?.call();
      } else {
        histories.assignAll(hisByPage);
      }
      _currentPage++;
    } else if (page > 1) {
      onLoadNoData?.call();
    } else {
      histories.clear();
    }
    _histories.refresh();
  }

  Future<void> _loadHistory(int page, {bool isShowLoading = true}) async {
    ProcessingDialog? processingDialog;
    if (page == 1 && isShowLoading) {
      processingDialog = ProcessingDialog.show();
    }
    HistoryReq reqData = _getReqFilter(page);
    var resp = await _historyHttp.getHistories(reqData);
    processingDialog?.hide();
    if (resp.isSuccess() &&
        resp.data != null &&
        resp.data!.items != null &&
        resp.data!.items!.isNotEmpty) {
      List<HistoryModel> hisData = resp.data!.items!;
      //cache history data
      await _historyCache.repo.putAndUpdate(hisData);
      //set status for pull down to load more
      if (page > 1) {
        histories.addAll(hisData);
        onLoadComplete?.call();
      } else {
        histories.assignAll(hisData);
      }
      //refresh UI history list
      _histories.refresh();
      if (resp.data!.currentPage != null) {
        _currentPage = resp.data!.currentPage!;
      }
      _currentPage++;
    } else {
      //get from cache
      _loadHistoryFromCache(page, reqData);
    }
  }

  Future<List<int>?> downloadFile(String path) async {
    var res = await _fileHttp.downloadFile(path);
    if (res.isSuccess() && res.data != null) {
      return res.data;
    } else {
      String errorMessage = res.getErrorMessage();
      SnackBars.error(message: errorMessage).show(duration: 5000);
      return null;
    }
  }

  Future<void> _loadPendingRequest(HistoryReq? filter) async {
    await _pendingRequestCache.init();
    List<PendingRequestModel> pendingData =
        _pendingRequestCache.repo.getPendingRequests();
    pendingData = pendingData.where(
      (element) {
        bool isSttValid = element.status == RequestStatus.failed.asString() ||
            element.status == RequestStatus.pending.asString();
        bool isFilterValid = true;
        if (filter != null && filter.fromTime != null) {
          isFilterValid = element.createAt.isBefore(filter.toTime) &&
              element.createAt.isAfter(filter.fromTime!);
        }
        return isSttValid && isFilterValid;
      },
    ).toList();
    if (pendingData.isNotEmpty) {
      List<HistoryModel> localHistories = <HistoryModel>[];
      for (PendingRequestModel pending in pendingData) {
        localHistories.add(
          HistoryModel.fromPendingRequest(
            pending.getRequestData(),
            pending.status,
            pending.errorCause,
            pending.createAt,
          ),
        );
      }
      histories.insertAll(0, localHistories);
      histories.sort(
        (b, a) => (a.recordedAt ?? 0).compareTo(b.recordedAt ?? 0),
      );
      _histories.refresh();
    }
  }
}
