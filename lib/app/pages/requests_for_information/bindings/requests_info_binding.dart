import 'package:usdol/app/core.dart';

class RequestsInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RequestsInfoController());
  }
}
