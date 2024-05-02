import 'package:usdol/app/core.dart';

class SellProductListBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<SellHttpService>()) {
      Get.put(SellHttpService());
    }
    Get.put(SellProductListController());
  }
}
