import 'package:usdol/app/core.dart';

class EditProfileBinding extends Bindings {
  EditProfileBinding();

  @override
  void dependencies() {
    Get.put(ProfileHttpService());
    Get.put(ProfileCerCacheService());
    Get.put(EditProfileController());
  }
}
