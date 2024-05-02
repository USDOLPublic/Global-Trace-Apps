import 'package:usdol/app/core.dart';

class PendingRequestRepo extends ActiveRepo<String, PendingRequestModel> {
  @override
  String get boxName => ModelTypeDefine.pendingRequestBox;

  List<PendingRequestModel> getPendingRequests() {
    Map<String, PendingRequestModel> pendingData = getAllValues();
    if (pendingData.isEmpty) {
      return [];
    }
    UserModel currentUser = Get.find<MainController>().userInfo;
    return pendingData.values
        .where(
          (pending) => pending.userId == currentUser.id,
        )
        .toList();
  }
}
