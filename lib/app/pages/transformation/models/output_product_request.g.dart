// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputProductRequest _$OutputProductRequestFromJson(
        Map<String, dynamic> json) =>
    OutputProductRequest(
      productDefinitionId: json['productDefinitionId'] as String?,
      outputProducts: (json['outputProducts'] as List<dynamic>?)
          ?.map((e) =>
              ManualAddedProductRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutputProductRequestToJson(
        OutputProductRequest instance) =>
    <String, dynamic>{
      'productDefinitionId': instance.productDefinitionId,
      'outputProducts': instance.outputProducts,
    };
