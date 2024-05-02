import 'package:usdol/app/core.dart';

class EditPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileHttpService());
    Get.put(EditPasswordController());
  }
}
