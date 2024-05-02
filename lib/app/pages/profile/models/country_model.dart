import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@HiveType(typeId: ModelTypeDefine.country)
@JsonSerializable()
class CountryModel extends HiveObject {
  CountryModel({
    this.id,
    this.countryCode,
    this.country,
    this.translation,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? countryCode;
  @HiveField(2)
  String? country;
  @HiveField(3)
  Map<String, dynamic>? translation;

  String getDisplayName({String language = ''}) {
    if (translation != null && translation!.containsKey(language)) {
      return translation![language].toString();
    }
    return country ?? '';
  }
}
