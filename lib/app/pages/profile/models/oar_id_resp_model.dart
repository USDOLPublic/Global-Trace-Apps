import 'package:usdol/app/core.dart';

class OarIDRespModel {
  OarIDRespModel({
    this.isMatched,
    this.name,
    this.address,
    this.countryCode,
    this.country,
    this.district,
    this.province,
    this.countryId,
    this.districtId,
    this.provinceId,
  });

  OarIDRespModel.fromJson(dynamic json) {
    isMatched = (json['isMatched'] ?? false) as bool;
    name = (json['name'] ?? '').toString();
    address = (json['address'] ?? '').toString();
    countryCode = (json['countryCode'] ?? '').toString();
    countryId = (json['countryId'] ?? '').toString();
    districtId = (json['districtId'] ?? '').toString();
    provinceId = (json['provinceId'] ?? '').toString();
    district =
    json['district'] == null
        ? null
        : DistrictModel.fromJson(json['district'] as Map<String, dynamic>);
    province =
    json['province'] == null
        ? null
        : ProvinceModel.fromJson(json['province'] as Map<String, dynamic>);
    country =
    json['country'] == null
        ? null
        : CountryModel.fromJson(json['country'] as Map<String, dynamic>);
  }

  bool? isMatched;
  String? name;
  String? address;
  String? countryCode;
  CountryModel? country;
  DistrictModel? district;
  ProvinceModel? province;
  String? countryId;
  String? districtId;
  String? provinceId;


  String get countryDisplayName => country?.country ?? '';
  String get districtDisplayName => district?.district ?? '';
  String get provinceDisplayName => province?.province ?? '';
}
