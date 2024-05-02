import 'package:usdol/app/core.dart';

part 'facility_resp_model.g.dart';

@HiveType(typeId: ModelTypeDefine.facilityResp)
class FacilityRespModel {
  FacilityRespModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.name,
    this.address,
    this.districtId,
    this.provinceId,
    this.countryId,
    this.traderName,
    this.certification,
    this.oarId,
    this.businessRegisterNumber,
    this.chainOfCustody,
    this.reconciliationStartAt,
    this.reconciliationDuration,
    this.deletedAt,
    this.users,
    this.farmGroupId,
    this.farmId,
    this.country,
    this.district,
    this.province,
    this.typeId,
  });

  factory FacilityRespModel.fromJson(Map<String, dynamic> json) {
    //Get farm group info
    String? farmGroupId;
    Map<String, dynamic> farmGroupObj = json;
    if (json["farmGroup"] != null &&
        json["farmGroup"] is Map<String, dynamic>) {
      farmGroupObj = json["farmGroup"] as Map<String, dynamic>;
    }
    if (farmGroupObj["farmGroupProfile"] != null &&
        farmGroupObj["farmGroupProfile"] is Map<String, dynamic>) {
      Map<String, dynamic> farmGroupProfile =
          farmGroupObj["farmGroupProfile"] as Map<String, dynamic>;
      if (farmGroupProfile["farmGroupId"] != null) {
        farmGroupId = farmGroupProfile["farmGroupId"].toString();
      }
    }
    //Get farm info
    String? farmId;
    if (json["farmProfile"] != null &&
        json["farmProfile"] is Map<String, dynamic>) {
      Map<String, dynamic> farmProfile =
          json["farmProfile"] as Map<String, dynamic>;
      if (farmProfile["farmProfileId"] != null) {
        farmId = farmProfile["farmProfileId"].toString();
      }
    }

    String? typeName;
    String? typeId;
    if (json["type"] != null && json["type"] is Map<String, dynamic>) {
      Map<String, dynamic> type = json["type"] as Map<String, dynamic>;
      if (type["name"] != null) {
        typeName = type["name"].toString();
      }
      if (type["name"] != null) {
        typeId = type["id"].toString();
      }
    }
    return FacilityRespModel(
      id: (json['id'] ?? '').toString(),
      createdAt: (json['createdAt'] ?? 0) as int,
      updatedAt: (json['updatedAt'] ?? 0) as int,
      type: typeName,
      typeId: typeId,
      name: (json['name'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      districtId: (json['districtId'] ?? '').toString(),
      provinceId: (json['provinceId'] ?? '').toString(),
      countryId: (json['countryId'] ?? '').toString(),
      traderName: (json['traderName'] ?? '').toString(),
      certification: (json['certification'] ?? '').toString(),
      oarId: (json['oarId'] ?? '').toString(),
      businessRegisterNumber: (json['businessRegisterNumber'] ?? '').toString(),
      chainOfCustody: (json['chainOfCustody'] ?? '').toString(),
      reconciliationStartAt: (json['reconciliationStartAt'] ?? 0) as int,
      reconciliationDuration: (json['reconciliationDuration'] ?? '').toString(),
      deletedAt: (json['deletedAt'] ?? 0) as int,
      users: json["users"] == null
          ? null
          : json["users"] is List
              ? List<FacilityUser>.from(
                  (json["users"] as List<dynamic>)
                      .map<FacilityUser?>((dynamic x) {
                    if (x is Map<String, dynamic>) {
                      return FacilityUser.fromJson(x);
                    } else {
                      return null;
                    }
                  }).toList(),
                )
              : null,
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      province: json['province'] == null
          ? null
          : ProvinceModel.fromJson(json['province'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : CountryModel.fromJson(json['country'] as Map<String, dynamic>),
      farmGroupId: farmGroupId,
      farmId: farmId,
    );
  }

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? type;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? districtId;
  @HiveField(7)
  String? provinceId;
  @HiveField(8)
  String? countryId;
  @HiveField(9)
  String? traderName;
  @HiveField(10)
  String? certification;
  @HiveField(11)
  String? oarId;
  @HiveField(12)
  String? businessRegisterNumber;
  @HiveField(13)
  String? chainOfCustody;
  @HiveField(14)
  int? reconciliationStartAt;
  @HiveField(15)
  String? reconciliationDuration;
  @HiveField(16)
  int? deletedAt;
  @HiveField(17)
  List<FacilityUser>? users;
  @HiveField(18)
  String? farmGroupId;
  @HiveField(19)
  String? farmId;
  @HiveField(20)
  DistrictModel? district;
  @HiveField(21)
  ProvinceModel? province;
  @HiveField(22)
  CountryModel? country;
  @HiveField(23)
  String? typeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['type'] = type;
    map['name'] = name;
    map['address'] = address;
    map['districtId'] = districtId;
    map['provinceId'] = provinceId;
    map['countryId'] = countryId;
    map['traderName'] = traderName;
    map['certification'] = certification;
    map['oarId'] = oarId;
    map['businessRegisterNumber'] = businessRegisterNumber;
    map['chainOfCustody'] = chainOfCustody;
    map['reconciliationStartAt'] = reconciliationStartAt;
    map['reconciliationDuration'] = reconciliationDuration;
    map['deletedAt'] = deletedAt;
    map['district'] = district;
    map['province'] = province;
    map['country'] = country;
    if (users != null) {
      map['users'] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  bool get isNonFarm => type == PartnerRoleName.nonFarm;

  String get countryDisplayName => country?.country ?? '';
  String get districtDisplayName => district?.district ?? '';
  String get provinceDisplayName => province?.province ?? '';
}

@HiveType(typeId: ModelTypeDefine.facilityUserResp)
class FacilityUser {
  FacilityUser({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.status,
    this.lastLoginAt,
    this.deletedAt,
    this.joinedAt,
    this.updatedProfileAt,
    this.answeredSaqAt,
    this.addedPartnerAt,
  });

  FacilityUser.fromJson(dynamic json) {
    id = (json['id'] ?? '').toString();
    createdAt = (json['createdAt'] ?? 0) as int;
    updatedAt = (json['updatedAt'] ?? 0) as int;
    email = (json['email'] ?? '').toString();
    phoneNumber = (json['phoneNumber'] ?? '').toString();
    firstName = (json['firstName'] ?? '').toString();
    lastName = (json['lastName'] ?? '').toString();
    status = (json['status'] ?? 0) as int;
    lastLoginAt = (json['lastLoginAt'] ?? 0) as int;
    deletedAt = (json['deletedAt'] ?? 0) as int;
    joinedAt = (json['joinedAt'] ?? 0) as int;
    updatedProfileAt = (json['updatedProfileAt'] ?? 0) as int;
    answeredSaqAt = (json['answeredSaqAt'] ?? 0) as int;
    addedPartnerAt = (json['addedPartnerAt'] ?? 0) as int;
  }

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? phoneNumber;
  @HiveField(5)
  String? firstName;
  @HiveField(6)
  String? lastName;
  @HiveField(7)
  int? status;
  @HiveField(8)
  int? lastLoginAt;
  @HiveField(9)
  int? deletedAt;
  @HiveField(10)
  int? joinedAt;
  @HiveField(11)
  int? updatedProfileAt;
  @HiveField(12)
  int? answeredSaqAt;
  @HiveField(13)
  int? addedPartnerAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['status'] = status;
    map['lastLoginAt'] = lastLoginAt;
    map['deletedAt'] = deletedAt;
    map['joinedAt'] = joinedAt;
    map['updatedProfileAt'] = updatedProfileAt;
    map['answeredSaqAt'] = answeredSaqAt;
    map['addedPartnerAt'] = addedPartnerAt;
    return map;
  }
}
