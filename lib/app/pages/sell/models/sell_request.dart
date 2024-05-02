import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sell_request.g.dart';

@JsonSerializable()
class SellRequest {
  List<String> productIds;
  List<ProductModel> products;
  String toFacilityId;
  String toFacilityName;
  String price;
  String currency;
  String invoiceNumber;
  String packingListNumber;
  int transactedAt;
  List<UploadFileResp>? uploadPackingLists;
  List<String>? localPackingLists;
  List<UploadFileResp>? uploadInvoices;
  List<String>? localInvoices;

  SellRequest({
    required this.productIds,
    required this.products,
    required this.toFacilityId,
    required this.toFacilityName,
    required this.price,
    required this.currency,
    required this.invoiceNumber,
    required this.packingListNumber,
    required this.transactedAt,
    this.uploadPackingLists,
    this.uploadInvoices,
    this.localPackingLists,
    this.localInvoices,
  });

  factory SellRequest.fromJson(Map<String, dynamic> json) =>
      _$SellRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SellRequestToJson(this);

  Map<String, dynamic> toRequest() {
    Map<String, dynamic> payload = _$SellRequestToJson(this);
    payload.remove('products');
    payload.remove('localPackingLists');
    payload.remove('localInvoices');
    double priceValue = double.tryParse(price) ?? 0;
    if (priceValue <= 0) {
      payload.remove('price');
    }
    return payload;
  }
}
