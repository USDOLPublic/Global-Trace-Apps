// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportRequest _$TransportRequestFromJson(Map<String, dynamic> json) =>
    TransportRequest(
      productIds: (json['productIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      toFacilityId: json['toFacilityId'] as String,
      toFacilityName: json['toFacilityName'] as String,
      totalWeight: (json['totalWeight'] as num).toDouble(),
      weightUnit: json['weightUnit'] as String,
      packingListNumber: json['packingListNumber'] as String,
      transactedAt: json['transactedAt'] as int,
      uploadPackingLists: (json['uploadPackingLists'] as List<dynamic>?)
          ?.map((e) => UploadFileResp.fromJson(e as Map<String, dynamic>))
          .toList(),
      localPackingLists: (json['localPackingLists'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TransportRequestToJson(TransportRequest instance) =>
    <String, dynamic>{
      'productIds': instance.productIds,
      'products': instance.products,
      'toFacilityId': instance.toFacilityId,
      'toFacilityName': instance.toFacilityName,
      'totalWeight': instance.totalWeight,
      'weightUnit': instance.weightUnit,
      'packingListNumber': instance.packingListNumber,
      'transactedAt': instance.transactedAt,
      'uploadPackingLists': instance.uploadPackingLists,
      'localPackingLists': instance.localPackingLists,
    };
