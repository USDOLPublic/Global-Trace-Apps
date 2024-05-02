import 'package:usdol/app/core.dart';

class InputProductListBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<TransformHttpService>()) {
      Get.put(TransformHttpService());
    }
    Get.put(InputProductListController());
  }
}
