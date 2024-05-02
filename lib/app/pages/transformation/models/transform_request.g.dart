// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transform_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransformRequest _$TransformRequestFromJson(Map<String, dynamic> json) =>
    TransformRequest(
      inputProducts: (json['inputProducts'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      inputProductIds: (json['inputProductIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      outputProduct: json['outputProduct'] == null
          ? null
          : OutputProductRequest.fromJson(
              json['outputProduct'] as Map<String, dynamic>),
      createAt: json['createAt'] as int?,
    );

Map<String, dynamic> _$TransformRequestToJson(TransformRequest instance) =>
    <String, dynamic>{
      'inputProductIds': instance.inputProductIds,
      'inputProducts': instance.inputProducts,
      'outputProduct': instance.outputProduct,
      'createAt': instance.createAt,
    };
