// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'margin_error_chart_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarginErrorChartResp _$MarginErrorChartRespFromJson(
        Map<String, dynamic> json) =>
    MarginErrorChartResp(
      canCalculate: json['canCalculate'] as bool?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MarginErrorChartRespToJson(
        MarginErrorChartResp instance) =>
    <String, dynamic>{
      'canCalculate': instance.canCalculate,
      'value': instance.value,
    };
