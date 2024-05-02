import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'districts_model.g.dart';

@HiveType(typeId: ModelTypeDefine.district)
@JsonSerializable()
class DistrictModel  extends HiveObject {
  DistrictModel({
    this.id,
    this.provinceId,
    this.districtCode,
    this.district,
    this.translation,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? provinceId;
  @HiveField(2)
  int? districtCode;
  @HiveField(3)
  String? district;
  @HiveField(4)
  Map<String, dynamic>? translation;

  String getDisplayName({String language = ''}) {
    if (translation != null && translation!.containsKey(language)) {
      return translation![language].toString();
    }
    return district ?? '';
  }
}
