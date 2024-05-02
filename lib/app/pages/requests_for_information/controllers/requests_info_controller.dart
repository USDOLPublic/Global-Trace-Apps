import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:usdol/app/core.dart';

class RequestsInfoController extends GetxController {
  late final RequestInformationHttpService _requestHttp;
  late final RequestInformationCacheService _requestCache;
  late final PendingRequestCacheService _pendingRequestCache;

  ScrollController scrollViewController = ScrollController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _requestInformation = <RequestInformationModel>[].obs;
  List<RequestInformationModel> get requestInformation =>
      // ignore: invalid_use_of_protected_member
      _requestInformation.value;
  set requestInformation(List<RequestInformationModel> value) =>
      _requestInformation.value = value;

  ExpandableController expandableController = ExpandableController();

  int _currentPage = 1;
  final int _pageSize = 20;

  @override
  void onInit() {
    _requestHttp = Get.find<RequestInformationHttpService>();
    _requestCache = Get.find<RequestInformationCacheService>();
    _pendingRequestCache = Get.find<PendingRequestCacheService>();
    super.onInit();
  }

  @override
  void onReady() {
    _initData();
    super.onReady();
  }

  Future<void> _initData() async {
    await _requestCache.init();
    _loadRequestForInformation(_currentPage);
  }

  Future<void> refreshData() async {
    _currentPage = 1;
    await _loadRequestForInformation(_currentPage);
  }

  Future<void> loadMoreRequestForInformation() async {
    await _loadRequestForInformation(_currentPage);
  }

  Future<void> _loadRequestForInformation(int page) async {
    ProcessingDialog? processingDialog;
    if (page == 1) {
      processingDialog = ProcessingDialog.show();
    }

    RequestInformationReq reqData = RequestInformationReq(
      page: page,
      perPage: _pageSize,
    );

    var resp = await _requestHttp.getRequestInformation(reqData);
    processingDialog?.hide();

    if (resp.isSuccess() &&
        resp.data?.items != null &&
        resp.data!.items!.isNotEmpty) {
      List<RequestInformationModel> requestData = resp.data!.items!;
      //cache history data
      await _requestCache.repo.putAndUpdate(requestData);

      //set status for pull down to load more
      if (page > 1) {
        requestInformation.addAll(requestData);
        refreshController.loadComplete();
      } else {
        requestInformation.assignAll(requestData);
      }
      //refresh UI history list
      _requestInformation.refresh();
      if (resp.data!.currentPage != null) {
        _currentPage = resp.data!.currentPage!;
      }
      _currentPage++;
    } else {
      //get from cache
      var requestData = _requestCache.repo.getPageItem(reqData);
      if (requestData.isNotEmpty) {
        if (page > 1) {
          requestInformation.addAll(requestData);
          refreshController.loadComplete();
        } else {
          requestInformation.assignAll(requestData);
        }
        _currentPage++;
      } else if (page > 1) {
        refreshController.loadNoData();
      } else {
        requestInformation.clear();
      }
      _requestInformation.refresh();
    }

    await _loadLocalHistory();
  }

  Future<void> _loadLocalHistory() async {
    await _pendingRequestCache.init();
    List<PendingRequestModel> pendingData =
        _pendingRequestCache.repo.getPendingRequests();
    pendingData = pendingData.where(
      (element) {
        bool isSttValid = element.status == RequestStatus.pending.asString();
        bool isTypeValid =
            element.type == RequestType.requestInformation.asString();
        return isSttValid && isTypeValid;
      },
    ).toList();
    if (pendingData.isNotEmpty) {
      List<RespondModel> respondsPending = <RespondModel>[];
      for (PendingRequestModel pending in pendingData) {
        dynamic pendingData = pending.getRequestData();
        if (pendingData is RespondModel) {
          respondsPending.add(pendingData);
        }
      }
      if (requestInformation.isNotEmpty && respondsPending.isNotEmpty) {
        for (RequestInformationModel item in requestInformation) {
          List<RespondModel> resOfRequest = respondsPending
              .where((element) => element.grievanceReportId == item.id)
              .toList();
          if (resOfRequest.isNotEmpty) {
            item.addAllRespond(resOfRequest);
            item.status = ReportStatusEnum.respondedSendStatus;
          }
        }
        _requestInformation.refresh();
      }
    }
  }
}
