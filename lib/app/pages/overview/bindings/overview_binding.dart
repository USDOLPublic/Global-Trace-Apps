import 'package:usdol/app/core.dart';

class OverviewBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<OverviewHttpService>()) {
      Get.put(OverviewHttpService());
    }
    Get.put(OverviewController());
  }
}
