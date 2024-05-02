import 'package:usdol/app/core.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileHttpService());
    Get.put(LoginController());
    Get.put(RegisterController());
  }
}