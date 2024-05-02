import 'package:usdol/app/core.dart';

class AddChildPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileHttpService());
    Get.put(CertificationCacheService());
    Get.put(InvitePartnerService());
    Get.put(AddChildPartnerController());
  }
}
