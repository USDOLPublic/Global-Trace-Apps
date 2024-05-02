// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartValue _$ChartValueFromJson(Map<String, dynamic> json) => ChartValue(
      canCalculate: json['canCalculate'] as bool?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ChartValueToJson(ChartValue instance) =>
    <String, dynamic>{
      'canCalculate': instance.canCalculate,
      'value': instance.value,
    };
