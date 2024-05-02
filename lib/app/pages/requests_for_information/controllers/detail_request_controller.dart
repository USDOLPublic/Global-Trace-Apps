import 'package:flutter/cupertino.dart';
import 'package:usdol/app/core.dart';

class DetailRequestController extends GetxController {
  final Rxn<RequestInformationModel> _requestInfo =
      Rxn<RequestInformationModel>();
  RequestInformationModel? get requestInfo => _requestInfo.value;
  set requestInfo(RequestInformationModel? requestInfoModel) =>
      _requestInfo.value = requestInfoModel;

  final Rx<int> _expandedIndex = 0.obs;
  int get expandedIndex => _expandedIndex.value;
  set expandedIndex(int value) => _expandedIndex.value = value;

  final ScrollController scrollController = ScrollController();

  late final RequestInformationHttpService _requestInformationHttp;
  late final UserModel userInfo;
  late final FileHttpService _fileHttpService;

  @override
  void onInit() {
    _fileHttpService = Get.find<FileHttpService>();
    _requestInformationHttp = Get.find<RequestInformationHttpService>();
    userInfo = MainController.to.userInfo;
    if (Get.arguments != null && Get.arguments is RequestInformationModel) {
      requestInfo = Get.arguments as RequestInformationModel;
      if (requestInfo!.responses?.isNotEmpty ?? false) {
        requestInfo!.responses!.sort(
          (a, b) => b.getCreateDate().compareTo(a.getCreateDate()),
        );
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    if (requestInfo?.status == ReportStatusEnum.newStatus &&
        requestInfo?.id != null) {
      _markViewedRespond(requestInfo!.id!);
    }
    super.onReady();
  }

  Future<bool> _markViewedRespond(String requestId) async {
    final result =
        await _requestInformationHttp.viewRequestInformation(requestId);
    if (result.isSuccess()) {
      requestInfo?.status = ReportStatusEnum.viewedStatus;
      _requestInfo.refresh();
    }
    return result.isSuccess();
  }

  Future<void> onTapResponseToRequest() async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.respondToRequest,
      arguments: requestInfo,
    );
    if (result != null && result is String) {
      SnackBars.complete(message: result).show(duration: 5000);
    }
  }

  void addRespond(RespondModel respond) {
    requestInfo?.addRespond(respond);
    requestInfo?.status = ReportStatusEnum.respondedSendStatus;
    if (requestInfo != null && (requestInfo!.responses?.isNotEmpty ?? false)) {
      requestInfo!.responses!
          .sort((a, b) => (b.getCreateDate()).compareTo(a.getCreateDate()));
    }
    expandedIndex = 0;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    _requestInfo.refresh();
  }

  Future<List<int>?> downloadFile(String path) async {
    var res = await _fileHttpService.downloadFile(path);
    if (res.isSuccess() && res.data != null) {
      return res.data;
    } else {
      String errorMessage = res.getErrorMessage();
      SnackBars.error(message: errorMessage).show(duration: 5000);
      return null;
    }
  }

  bool hasPermissionRespond() {
    return userInfo.hasPermission(PermissionActionDef.reactiveAssessments);
  }
}
