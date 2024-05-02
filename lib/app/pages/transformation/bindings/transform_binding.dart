import 'package:usdol/app/core.dart';

class TransformBinding extends Bindings {
  @override
  void dependencies() {
    var transformHttpService = Get.put(TransformHttpService());
    Get.put(TransformScheduleSending(
      fileHttpService: Get.find<FileHttpService>(),
      transformHttpService: transformHttpService,
    ));
    if (Get.isRegistered<PurchaseHttpService>()) {
      Get.put(PurchaseHttpService());
    }
    Get.put(TransformController());
  }
}
