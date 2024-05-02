import 'package:usdol/app/core.dart';

class AddPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileHttpService());
    Get.put(CertificationCacheService());
    Get.put(InvitePartnerPermissionCacheService());
    Get.put(InvitePartnerService());
    Get.put(AddPartnerController());
  }
}
