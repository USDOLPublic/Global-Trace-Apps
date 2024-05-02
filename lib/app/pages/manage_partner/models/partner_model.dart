import 'package:usdol/app/core.dart';

class PartnerModel {
  PartnerModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.name,
    this.address,
    this.district,
    this.province,
    this.country,
    this.traderName,
    this.certification,
    this.oarId,
    this.businessRegisterNumber,
    this.reconciliationStartAt,
    this.reconciliationDuration,
    this.deletedAt,
    this.users,
  });

  PartnerModel.fromJson(dynamic json) {
    id = (json['id'] ?? '').toString();
    createdAt = json['createdAt'] as int;
    updatedAt = json['updatedAt'] as int;
    type = json['type'] as int;
    name = (json['name'] ?? '').toString();
    address = (json['address'] ?? '').toString();
    district = json['district'] == null
        ? null
        : DistrictModel.fromJson(json['district'] as Map<String, dynamic>);
    province = json['province'] == null
        ? null
        : ProvinceModel.fromJson(json['province'] as Map<String, dynamic>);
    country = json['country'] == null
        ? null
        : CountryModel.fromJson(json['country'] as Map<String, dynamic>);
    traderName = (json['traderName'] ?? '').toString();
    certification = (json['certification'] ?? '').toString();
    oarId = (json['oarId'] ?? '').toString();
    businessRegisterNumber = (json['businessRegisterNumber'] ?? '').toString();
    reconciliationStartAt = json['reconciliationStartAt'];
    reconciliationDuration = json['reconciliationDuration'];
    deletedAt = json['deletedAt'];
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((Map<String, dynamic> v) {
        users?.add(UserModel.fromJson(v));
      });
    }
  }

  String? id;
  int? createdAt;
  int? updatedAt;
  int? type;
  String? name;
  String? address;
  DistrictModel? district;
  ProvinceModel? province;
  CountryModel? country;
  String? traderName;
  dynamic certification;
  String? oarId;
  String? businessRegisterNumber;
  dynamic reconciliationStartAt;
  dynamic reconciliationDuration;
  dynamic deletedAt;
  List<UserModel>? users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['type'] = type;
    map['name'] = name;
    map['address'] = address;
    map['districtId'] = district?.id;
    map['provinceId'] = province?.id;
    map['countryId'] = country?.id;
    map['traderName'] = traderName;
    map['certification'] = certification;
    map['oarId'] = oarId;
    map['businessRegisterNumber'] = businessRegisterNumber;
    map['reconciliationStartAt'] = reconciliationStartAt;
    map['reconciliationDuration'] = reconciliationDuration;
    map['deletedAt'] = deletedAt;
    if (users != null) {
      map['users'] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
