import 'package:usdol/app/core.dart';

class TransportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TransportController());
  }
}
