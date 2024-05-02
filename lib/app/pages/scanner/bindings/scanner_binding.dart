import 'package:usdol/app/core.dart';

class ScannerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ScannerController());
  }
}