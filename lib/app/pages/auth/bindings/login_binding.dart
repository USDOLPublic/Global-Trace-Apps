import 'package:usdol/app/core.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileHttpService());
    Get.put(LoginController());
  }
}