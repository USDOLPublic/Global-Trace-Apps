import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_info_resp.g.dart';

@JsonSerializable()
class RequestInfoResp {
  RequestInfoResp({
    this.total,
    this.lastPage,
    this.perPage,
    this.currentPage,
    this.items,
  });

  int? total;
  int? lastPage;
  int? perPage;
  int? currentPage;
  List<RequestInformationModel>? items;
  factory RequestInfoResp.fromJson(Map<String, dynamic> json) =>
      _$RequestInfoRespFromJson(json);

  Map<String, dynamic> toJson() => _$RequestInfoRespToJson(this);
}
