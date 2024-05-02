// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_info_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestInfoResp _$RequestInfoRespFromJson(Map<String, dynamic> json) =>
    RequestInfoResp(
      total: json['total'] as int?,
      lastPage: json['lastPage'] as int?,
      perPage: json['perPage'] as int?,
      currentPage: json['currentPage'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              RequestInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestInfoRespToJson(RequestInfoResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'lastPage': instance.lastPage,
      'perPage': instance.perPage,
      'currentPage': instance.currentPage,
      'items': instance.items,
    };
