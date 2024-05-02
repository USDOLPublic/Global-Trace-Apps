import 'package:usdol/app/core.dart';

class AddProductManuallyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AddProductManuallyController());
  }
}
