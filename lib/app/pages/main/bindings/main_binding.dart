import 'package:usdol/app/core.dart';
class MainBinding extends Bindings {
  @override
  void dependencies() {
    SessionStore ssStore = Get.put<SessionStore>(SessionStore());
    AuthHttpService authHttp = Get.put<AuthHttpService>(AuthHttpService());
    var sessionM = SessionManager(store: ssStore, authService: authHttp);
    Get.put<SessionManager>(sessionM);
    Get.put(SAQCacheService());
    Get.put(SAQHttpService());
    Get.put<UserCacheService>(UserCacheService());
    Get.put<FileHttpService>(FileHttpService());
    Get.put(MainController());
  }
}
