import 'package:usdol/app/core.dart';

class DetailRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailRequestController());
  }
}
