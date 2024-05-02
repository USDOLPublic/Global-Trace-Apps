import 'package:usdol/app/core.dart';

class PurchaseProductListBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<PurchaseHttpService>()) {
      Get.put(PurchaseHttpService());
    }
    Get.put(PurchaseProductListController());
  }
}
