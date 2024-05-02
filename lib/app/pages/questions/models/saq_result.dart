import 'package:usdol/app/core.dart';

class SAQResult {
  bool isSuccess;
  String message;
  SAQStatusEnum status;
  List<SaqSubmitResp>? submitResp;

  SAQResult({
    this.isSuccess = false,
    this.message = "",
    this.status = SAQStatusEnum.none,
    this.submitResp,
  });
}
