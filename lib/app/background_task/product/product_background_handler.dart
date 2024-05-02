import 'dart:async';
import 'dart:convert';
import 'package:usdol/app/core.dart';

class ProductBackgroundHandler {
  final PurchaseScheduleSending purchaseSchedule;
  final SellScheduleSending sellSchedule;
  final TransportScheduleSending transportSchedule;
  final TransformScheduleSending transformSchedule;
  final RecordProductHttpService recordProductHttp;
  final PendingRequestCacheService pendingRequestCache;
  bool _isSubmitting = false;

  final StreamController<SyncResponse> _syncCompletedStreamController =
      StreamController.broadcast();
  Stream<SyncResponse> get syncStream => _syncCompletedStreamController.stream;

  final StreamController<bool> _syncStartStreamController =
      StreamController.broadcast();
  Stream<bool> get syncStartStream => _syncStartStreamController.stream;

  ProductBackgroundHandler({
    required this.purchaseSchedule,
    required this.sellSchedule,
    required this.transportSchedule,
    required this.transformSchedule,
    required this.recordProductHttp,
    required this.pendingRequestCache,
  });

  bool get isSyncing => _isSubmitting;

  Future<void> submitPendingData({bool isAutoTrigger = true}) async {
    LogUtil.d("Enter submit pending data");
    if (_isSubmitting) {
      LogUtil.d("Reject event. because pending data have submitting");
      return;
    }
    _isSubmitting = true;
    _syncStartStreamController.add(isAutoTrigger);
    if (isAutoTrigger) {
      await Future<void>.delayed(const Duration(milliseconds: 3000));
    }
    bool isConnected = await NetworkUtil.isConnected();
    if (!isConnected) {
      _syncCompletedStreamController.add(
        SyncResponse(
          isAutoTrigger: isAutoTrigger,
          status: SyncStatus.canceled,
        ),
      );
      _isSubmitting = false;
      return;
    }
    //Load Pending data
    await pendingRequestCache.init();
    List<PendingRequestModel> pendingData =
        pendingRequestCache.repo.getPendingRequests();
    pendingData = pendingData.where((element) => element.isPending).toList();
    //
    //check pending data
    if (pendingData.isEmpty) {
      _syncCompletedStreamController.add(
        SyncResponse(
          isAutoTrigger: isAutoTrigger,
          status: SyncStatus.pendingDataEmpty,
        ),
      );
      _isSubmitting = false;
      return;
    }
    List<String> completedKeys = <String>[];

    //sort and set schedule for resubmit
    pendingData.sort((a, b) => a.createAt.compareTo(b.createAt));
    await Future.forEach(pendingData, (PendingRequestModel pending) async {
      //Execute submit
      BaseResp<dynamic>? submitResult = await _executeResubmit(pending);
      RequestStatus respStatus = RequestStatus.pending;
      String errorCause = "";
      //check response
      if (submitResult == null) {
        errorCause = "Can't parsed pending data!";
        respStatus = RequestStatus.failed;
      } else if (submitResult.isSuccess()) {
        respStatus = RequestStatus.completed;
        completedKeys.add(pending.id);
      } else if (!OfflineHttpStatus.pendingStatus
          .contains(submitResult.statusCode)) {
        respStatus = RequestStatus.failed;
        errorCause = submitResult.getErrorMessage();
      }
      //Update status after submit
      pending.status = respStatus.asString();
      pending.errorCause = errorCause;
      await pendingRequestCache.repo.putAndUpdateExisting(
        pending.id,
        pending,
        (key, oldValue, value) => value,
      );
    });

    //remove request completed
    if (completedKeys.isNotEmpty) {
      LogUtil.d("Submit pending data: ${jsonEncode(completedKeys)}");
      await pendingRequestCache.repo.deleteKeys(completedKeys);
    }
    _syncCompletedStreamController.add(
      SyncResponse(
        isAutoTrigger: isAutoTrigger,
        status: completedKeys.isEmpty
            ? SyncStatus.completed
            : SyncStatus.completedWithDataSubmitted,
      ),
    );
    _isSubmitting = false;
  }

  Future<BaseResp<dynamic>?> _executeResubmit(
      PendingRequestModel request) async {
    Map<String, dynamic>? reqJson = request.getRequestDataJs();
    if (reqJson == null) {
      return null;
    }
    LogUtil.d(
        "Enter Execute Resubmit: type: ${request.requestType.asString()} reqJson: ${jsonEncode(reqJson)}");
    switch (request.requestType) {
      case RequestType.purchase:
        PurchaseRequest req = PurchaseRequest.fromJson(reqJson);
        LogUtil.d("Enter Execute Resubmit");
        return await purchaseSchedule.sendRequestPurchase(req);
      case RequestType.sell:
        SellRequest req = SellRequest.fromJson(reqJson);
        //Check lot validation and update id.
        return await sellSchedule.sendRequestSell(req);
      case RequestType.assignProduct:
        TransformRequest req = TransformRequest.fromJson(reqJson);
        //Assign product
        return await transformSchedule.sendRequestTransform(req);
      case RequestType.transport:
        TransportRequest req = TransportRequest.fromJson(reqJson);
        return await transportSchedule.sendRequestTransport(req);
      case RequestType.recordByProduct:
        RecordProductRequest req = RecordProductRequest.fromJson(reqJson);
        return await recordProductHttp.logRecordByProduct(req);
      default:
        return null;
    }
  }
}
