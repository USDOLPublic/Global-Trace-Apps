// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellRequest _$SellRequestFromJson(Map<String, dynamic> json) => SellRequest(
      productIds: (json['productIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      toFacilityId: json['toFacilityId'] as String,
      toFacilityName: json['toFacilityName'] as String,
      price: json['price'] as String,
      currency: json['currency'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      packingListNumber: json['packingListNumber'] as String,
      transactedAt: json['transactedAt'] as int,
      uploadPackingLists: (json['uploadPackingLists'] as List<dynamic>?)
          ?.map((e) => UploadFileResp.fromJson(e as Map<String, dynamic>))
          .toList(),
      uploadInvoices: (json['uploadInvoices'] as List<dynamic>?)
          ?.map((e) => UploadFileResp.fromJson(e as Map<String, dynamic>))
          .toList(),
      localPackingLists: (json['localPackingLists'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      localInvoices: (json['localInvoices'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SellRequestToJson(SellRequest instance) =>
    <String, dynamic>{
      'productIds': instance.productIds,
      'products': instance.products,
      'toFacilityId': instance.toFacilityId,
      'toFacilityName': instance.toFacilityName,
      'price': instance.price,
      'currency': instance.currency,
      'invoiceNumber': instance.invoiceNumber,
      'packingListNumber': instance.packingListNumber,
      'transactedAt': instance.transactedAt,
      'uploadPackingLists': instance.uploadPackingLists,
      'localPackingLists': instance.localPackingLists,
      'uploadInvoices': instance.uploadInvoices,
      'localInvoices': instance.localInvoices,
    };
