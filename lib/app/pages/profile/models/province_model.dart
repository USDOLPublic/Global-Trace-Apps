import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'province_model.g.dart';

@HiveType(typeId: ModelTypeDefine.province)
@JsonSerializable()
class ProvinceModel extends HiveObject {
  ProvinceModel({
    this.id,
    this.countryId,
    this.provinceCode,
    this.province,
    this.translation,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>_$ProvinceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceModelToJson(this);
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? countryId;
  @HiveField(2)
  dynamic provinceCode;
  @HiveField(3)
  String? province;
  @HiveField(4)
  Map<String, dynamic>? translation;

   String getDisplayName({String language = ''}) {
    if (translation != null && translation!.containsKey(language)) {
      return translation![language].toString();
    }
    return province ?? '';
  }

  String getProvinceCode() => (provinceCode??'').toString();
}
