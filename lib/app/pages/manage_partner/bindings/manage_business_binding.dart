import 'package:usdol/app/core.dart';

class ManageBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InvitePartnerService());
    Get.put(ManagePartnerCacheService());
    Get.put(ManageBusinessController());
  }
}
