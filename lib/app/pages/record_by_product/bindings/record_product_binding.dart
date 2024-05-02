import 'package:usdol/app/core.dart';

class RecordProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RecordProductHttpService());
    Get.put(RecordProductController());
  }
}
