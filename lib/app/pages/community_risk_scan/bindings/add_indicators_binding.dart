import 'package:usdol/app/core.dart';

class AddIndicatorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddIndicatorController());
  }
}
