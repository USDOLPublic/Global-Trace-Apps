import 'package:usdol/app/core.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }
}
