import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'transform_request.g.dart';

@JsonSerializable()
class TransformRequest {
  TransformRequest({
    this.inputProducts,
    this.inputProductIds,
    this.outputProduct,
    this.createAt,
  });

  List<String>? inputProductIds;
  List<ProductModel>? inputProducts;
  OutputProductRequest? outputProduct;
  int? createAt;

  factory TransformRequest.fromJson(Map<String, dynamic> json) =>
      _$TransformRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransformRequestToJson(this);

  Map<String, dynamic> toRequest() {
    Map<String, dynamic> payload = _$TransformRequestToJson(this);
    payload.remove('inputProducts');
    payload.remove('createAt');
    return payload;
  }
}
