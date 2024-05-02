import 'package:usdol/app/core.dart';

class RegisterOarIdBinding extends Bindings {
  @override
  void dependencies() {
    String? tagId = Get.parameters['tagId'];
    Get.put(ProfileHttpService(), tag: tagId);
    Get.put(RegisterOarIdController(), tag: tagId);
  }
}
