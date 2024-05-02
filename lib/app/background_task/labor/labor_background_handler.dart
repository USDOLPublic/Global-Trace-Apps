import 'dart:convert';
import 'package:usdol/app/core.dart';

class LaborBackgroundHandler {
  final RiskScanScheduleSending riskScanSchedule;
  final PendingRequestCacheService pendingRequestCache;
  final RequestInformationScheduleSending requestInfoSchedule;
  bool _isSubmitting = false;

  LaborBackgroundHandler({
    required this.riskScanSchedule,
    required this.pendingRequestCache,
    required this.requestInfoSchedule,
  });

  Future<void> submitPendingData() async {
    LogUtil.d("Enter submit pending data");
    if (_isSubmitting) {
      LogUtil.d("Reject event. because pending data have submitting");
      return;
    }
    _isSubmitting = true;
    await Future<void>.delayed(const Duration(milliseconds: 3000));
    bool isConnected = await NetworkUtil.isConnected();
    if (isConnected) {
      //Load Pending data
      await pendingRequestCache.init();
      List<PendingRequestModel> pendingData =
          pendingRequestCache.repo.getPendingRequests();
      pendingData = pendingData
          .where(
              (element) => element.status == RequestStatus.pending.asString())
          .toList();
      //
      List<String> completedKeys = <String>[];
      //check pending data
      if (pendingData.isNotEmpty) {
        //sort and set schedule for resubmit
        pendingData.sort((a, b) => a.createAt.compareTo(b.createAt));
        await Future.forEach(pendingData, (PendingRequestModel pending) async {
          //Execute submit
          BaseResp? submitResult = await _executeResubmit(pending);
          RequestStatus respStatus = RequestStatus.failed;
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
      }

      //remove request completed
      if (completedKeys.isNotEmpty) {
        LogUtil.d("Submit pending data: ${jsonEncode(completedKeys)}");
        await pendingRequestCache.repo.deleteKeys(completedKeys);
        _syncData();
      }
      _isSubmitting = false;
    }
  }

  ///
  ///Sync data for home page after have any pending form submitted
  void _syncData() {
    if (Get.isRegistered<RequestsInfoController>()) {
      Get.find<RequestsInfoController>().refreshData();
    }
  }

  Future<BaseResp?> _executeResubmit(PendingRequestModel request) async {
    Map<String, dynamic>? reqJson = request.getRequestDataJs();
    if (reqJson == null) {
      return null;
    }
    LogUtil.d(
        "Enter Execute Resubmit: type: ${request.requestType.asString()} reqJson: ${jsonEncode(reqJson)}");
    switch (request.requestType) {
      case RequestType.community:
        RiskScanRequest req = RiskScanRequest.fromJson(reqJson);
        LogUtil.d("Enter Execute Resubmit");
        return riskScanSchedule.sendRiskScanRequest(req);
      case RequestType.requestInformation:
        RespondModel req = RespondModel.fromJson(reqJson);
        return requestInfoSchedule.sendRespondRequest(
          payload: req,
          reportId: req.grievanceReportId ?? '',
        );
      default:
        return null;
    }
  }
}
