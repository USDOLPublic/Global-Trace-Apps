// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_chart_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculationChartResp _$CalculationChartRespFromJson(
        Map<String, dynamic> json) =>
    CalculationChartResp(
      totalByProduct: json['totalByProduct'] == null
          ? null
          : ChartValue.fromJson(json['totalByProduct'] as Map<String, dynamic>),
      totalInputs: json['totalInputs'] == null
          ? null
          : ChartValue.fromJson(json['totalInputs'] as Map<String, dynamic>),
      totalOutputs: json['totalOutputs'] == null
          ? null
          : ChartValue.fromJson(json['totalOutputs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalculationChartRespToJson(
        CalculationChartResp instance) =>
    <String, dynamic>{
      'totalInputs': instance.totalInputs,
      'totalOutputs': instance.totalOutputs,
      'totalByProduct': instance.totalByProduct,
    };
