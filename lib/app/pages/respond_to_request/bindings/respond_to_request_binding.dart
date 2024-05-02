import 'package:usdol/app/core.dart';

class RespondToRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RespondToRequestController());
  }
}
