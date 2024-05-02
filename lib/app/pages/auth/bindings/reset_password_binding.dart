import 'package:usdol/app/core.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordController());
  }
}
