import 'package:usdol/app/core.dart';

class OnboardBinding extends Bindings {
  OnboardBinding();

  @override
  void dependencies() {
    Get.put(ProfileHttpService());
    Get.put(UserCacheService());
    Get.put(OnboardController());
  }
}
