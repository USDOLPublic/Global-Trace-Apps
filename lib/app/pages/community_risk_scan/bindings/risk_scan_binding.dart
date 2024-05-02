import 'package:usdol/app/core.dart';

class RiskScanBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RiskScanController());
  }
}