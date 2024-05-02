// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonTimeModel _$SeasonTimeModelFromJson(Map<String, dynamic> json) =>
    SeasonTimeModel(
      seasonDuration: json['seasonDuration'] as int?,
      seasonStartTime: json['seasonStartTime'] as int?,
    );

Map<String, dynamic> _$SeasonTimeModelToJson(SeasonTimeModel instance) =>
    <String, dynamic>{
      'seasonStartTime': instance.seasonStartTime,
      'seasonDuration': instance.seasonDuration,
    };
