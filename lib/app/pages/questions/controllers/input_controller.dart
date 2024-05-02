import 'package:usdol/app/core.dart';

class InputController extends GetxController {
  String? question;
  int index;
  List<String>? responseOption;
  List<String>? responseInput;
  Function? onChangeResponse;

  InputController({
    this.question,
    this.index = 0,
    this.onChangeResponse,
    this.responseOption,
    this.responseInput,
  });
}
