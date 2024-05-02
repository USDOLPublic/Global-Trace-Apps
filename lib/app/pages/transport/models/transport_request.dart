import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transport_request.g.dart';

@JsonSerializable()
class TransportRequest {
  List<String> productIds;
  List<ProductModel> products;
  String toFacilityId;
  String toFacilityName;
  double totalWeight;
  String weightUnit;
  String packingListNumber;
  int transactedAt;
  List<UploadFileResp>? uploadPackingLists;
  List<String>? localPackingLists;

  TransportRequest({
    required this.productIds,
    required this.products,
    required this.toFacilityId,
    required this.toFacilityName,
    required this.totalWeight,
    required this.weightUnit,
    required this.packingListNumber,
    required this.transactedAt,
    this.uploadPackingLists,
    this.localPackingLists,
  });

  factory TransportRequest.fromJson(Map<String, dynamic> json) =>
      _$TransportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransportRequestToJson(this);

  Map<String, dynamic> toRequest() {
    Map<String, dynamic> payload = _$TransportRequestToJson(this);
    payload.remove('products');
    payload.remove('localPackingLists');
    return payload;
  }
}
