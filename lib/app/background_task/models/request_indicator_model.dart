import 'package:usdol/app/core.dart';

class RequestIndicator extends BaseReq {
  int? type;
  String? parentid;

  RequestIndicator({
    this.type,
    this.parentid,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "type": type,
      "parentid": parentid,
    };
  }
}
