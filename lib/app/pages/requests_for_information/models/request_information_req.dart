import 'package:usdol/app/core.dart';

class RequestInformationReq extends BaseReq {
  int page;
  int perPage;

  RequestInformationReq({
    required this.page,
    required this.perPage,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "page": page,
      "perPage": perPage,
    };
  }
}