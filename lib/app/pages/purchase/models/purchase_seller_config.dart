import 'package:json_annotation/json_annotation.dart';
part 'purchase_seller_config.g.dart';

@JsonSerializable()
class PurchaseSellerConfig {
  final bool? isSellerRequired;
  final String? nonParticipatingRoleName;
  PurchaseSellerConfig({
    this.isSellerRequired,
    this.nonParticipatingRoleName,
  });

  factory PurchaseSellerConfig.fromJson(Map<String, dynamic> json) =>
      _$PurchaseSellerConfigFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PurchaseSellerConfigToJson(this);
}
