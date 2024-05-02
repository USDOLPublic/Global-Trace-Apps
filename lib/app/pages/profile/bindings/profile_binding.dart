import 'package:usdol/app/core.dart';

class ProfileBinding extends Bindings {
  ProfileBinding();

  @override
  void dependencies() {
    Get.put(ProfileHttpService());
    Get.put(UserCacheService());
    Get.put(ProfileController());
  }
}
