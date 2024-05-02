// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseRequest _$PurchaseRequestFromJson(Map<String, dynamic> json) =>
    PurchaseRequest(
      fromFacilityId: json['fromFacilityId'] as String?,
      price: json['price'] as String?,
      currency: json['currency'] as String?,
      purchaseOrderNumber: json['purchaseOrderNumber'] as String?,
      transactedAt: json['transactedAt'] as int?,
      uploadProofs: (json['uploadProofs'] as List<dynamic>?)
          ?.map((e) => UploadFileResp.fromJson(e as Map<String, dynamic>))
          .toList(),
      manualAddedData: json['manualAddedData'] == null
          ? null
          : ManualAddedDataRequest.fromJson(
              json['manualAddedData'] as Map<String, dynamic>),
      productIds: (json['productIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      localProofs: (json['localProofs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fromFacilityName: json['fromFacilityName'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseRequestToJson(PurchaseRequest instance) =>
    <String, dynamic>{
      'fromFacilityId': instance.fromFacilityId,
      'price': instance.price,
      'currency': instance.currency,
      'purchaseOrderNumber': instance.purchaseOrderNumber,
      'transactedAt': instance.transactedAt,
      'uploadProofs': instance.uploadProofs,
      'manualAddedData': instance.manualAddedData,
      'productIds': instance.productIds,
      'localProofs': instance.localProofs,
      'products': instance.products,
      'fromFacilityName': instance.fromFacilityName,
    };
