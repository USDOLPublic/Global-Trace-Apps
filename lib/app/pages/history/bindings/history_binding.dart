import 'package:usdol/app/core.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HistoryController());
  }
}
