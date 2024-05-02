import 'package:usdol/app/core.dart';

class SellBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SellController());
  }
}