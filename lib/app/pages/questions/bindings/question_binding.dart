import 'package:usdol/app/core.dart';

class QuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SAQHttpService());
    Get.put(SAQCacheService());
    Get.put(QuestionController());
  }

}