import 'package:usdol/app/core.dart';

class PurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PurchaseController());
  }
}
