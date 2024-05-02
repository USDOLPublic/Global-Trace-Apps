import 'package:usdol/app/core.dart';

class TransportProductListBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<TransportHttpService>()) {
      Get.put(TransportHttpService());
    }
    Get.put(TransportProductListController());
  }
}
