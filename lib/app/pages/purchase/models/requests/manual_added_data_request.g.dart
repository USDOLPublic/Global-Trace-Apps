// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_added_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManualAddedDataRequest _$ManualAddedDataRequestFromJson(
        Map<String, dynamic> json) =>
    ManualAddedDataRequest(
      productDefinitionId: json['productDefinitionId'] as String?,
      manualAddedProducts: (json['manualAddedProducts'] as List<dynamic>?)
          ?.map((e) =>
              ManualAddedProductRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManualAddedDataRequestToJson(
        ManualAddedDataRequest instance) =>
    <String, dynamic>{
      'productDefinitionId': instance.productDefinitionId,
      'manualAddedProducts': instance.manualAddedProducts,
    };
