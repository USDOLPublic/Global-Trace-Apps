// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mass_balance_chart_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MassBalanceChartResp _$MassBalanceChartRespFromJson(
        Map<String, dynamic> json) =>
    MassBalanceChartResp(
      canCalculate: json['canCalculate'] as bool?,
      lastUpdatedAt: json['lastUpdatedAt'] as int?,
      notVerifiedQuantity: (json['notVerifiedQuantity'] as num?)?.toDouble(),
      quantityUnit: json['quantityUnit'] as String?,
      verifiedQuantity: (json['verifiedQuantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MassBalanceChartRespToJson(
        MassBalanceChartResp instance) =>
    <String, dynamic>{
      'canCalculate': instance.canCalculate,
      'verifiedQuantity': instance.verifiedQuantity,
      'notVerifiedQuantity': instance.notVerifiedQuantity,
      'lastUpdatedAt': instance.lastUpdatedAt,
      'quantityUnit': instance.quantityUnit,
    };
