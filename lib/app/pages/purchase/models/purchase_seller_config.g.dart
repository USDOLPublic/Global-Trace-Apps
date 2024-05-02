// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_seller_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseSellerConfig _$PurchaseSellerConfigFromJson(
        Map<String, dynamic> json) =>
    PurchaseSellerConfig(
      isSellerRequired: json['isSellerRequired'] as bool?,
      nonParticipatingRoleName: json['nonParticipatingRoleName'] as String?,
    );

Map<String, dynamic> _$PurchaseSellerConfigToJson(
        PurchaseSellerConfig instance) =>
    <String, dynamic>{
      'isSellerRequired': instance.isSellerRequired,
      'nonParticipatingRoleName': instance.nonParticipatingRoleName,
    };
