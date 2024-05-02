import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'purchase_request.g.dart';

@JsonSerializable()
class PurchaseRequest {
  final String? fromFacilityId;
  final String? price;
  final String? currency;
  final String? purchaseOrderNumber;
  final int? transactedAt;
  List<UploadFileResp>? uploadProofs;
  final ManualAddedDataRequest? manualAddedData;
  List<String>? productIds;
  final List<String>? localProofs;
  List<ProductModel>? products;
  final String? fromFacilityName;

  PurchaseRequest({
    this.fromFacilityId,
    this.price,
    this.currency,
    this.purchaseOrderNumber,
    this.transactedAt,
    this.uploadProofs,
    this.manualAddedData,
    this.productIds,
    this.localProofs,
    this.fromFacilityName,
    this.products,
  });

  factory PurchaseRequest.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseRequestToJson(this);

  Map<String, dynamic> toRequest() {
    Map<String, dynamic> payload = _$PurchaseRequestToJson(this);
    payload.remove('localProofs');
    payload.remove('products');
    payload.remove('fromFacilityName');
    double priceValue = double.tryParse(price ?? '0') ?? 0;
    if (priceValue <= 0) {
      payload.remove('price');
    }
    return payload;
  }
}
