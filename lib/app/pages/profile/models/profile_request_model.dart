import 'package:usdol/app/core.dart';

class ProfileRequestModel {
  ProfileRequestModel({
    this.user,
    this.facility,
  });

  User? user;
  FacilityReq? facility;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (facility != null) {
      map['facility'] = facility?.toJson();
    }
    return map;
  }
}

class FacilityReq {
  FacilityReq({
    this.traderName,
    this.businessRegisterNumber,
    this.oarId,
    this.certification,
    this.name,
    this.address,
    this.district,
    this.province,
    this.country,
    this.chainOfCustody,
    this.reconciliationDuration,
    this.reconciliationStartAt,
    this.districtId,
    this.provinceId,
    this.countryId,
    this.goods,
  });

  String? traderName;
  String? businessRegisterNumber;
  String? oarId;
  String? certification;
  String? name;
  String? address;
  DistrictModel? district;
  ProvinceModel? province;
  CountryModel? country;
  String? chainOfCustody;
  String? reconciliationDuration;
  DateTime? reconciliationStartAt;
  String? districtId;
  String? provinceId;
  String? countryId;
  List<String>? goods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (traderName != null) {
      map['traderName'] = traderName;
    }
    if (businessRegisterNumber != null) {
      map['businessRegisterNumber'] = businessRegisterNumber;
    }
    if (oarId != null) {
      map['oarId'] = oarId;
    }
    if (certification != null) {
      map['certification'] = certification;
    }
    if (address != null) {
      map['address'] = address;
    }
    map['name'] = name;
    if (districtId != null) {
      map['districtId'] = districtId;
    }
    if (provinceId != null) {
      map['provinceId'] = provinceId;
    }
    if (countryId != null) {
      map['countryId'] = countryId;
    }
    if (reconciliationDuration != null) {
      map['reconciliationDuration'] = reconciliationDuration;
    }
    if (reconciliationStartAt != null) {
      map['reconciliationStartAt'] =
          (reconciliationStartAt?.millisecondsSinceEpoch ?? 0) ~/ 1000;
    }
    if (goods != null) {
      map['goods'] = goods;
    }
    return map;
  }

  String get countryDisplayName => country?.country ?? '';
  String get districtDisplayName => district?.district ?? '';
  String get provinceDisplayName => province?.province ?? '';
}

class User {
  User({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  User.fromJson(dynamic json) {
    email = (json['email'] ?? '').toString();
    firstName = (json['firstName'] ?? '').toString();
    lastName = (json['lastName'] ?? '').toString();
    phoneNumber = (json['phoneNumber'] ?? '').toString();
  }

  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    if (phoneNumber != null && phoneNumber!.trim().isEmpty) {
      phoneNumber = null;
    }
    map['phoneNumber'] = phoneNumber;
    return map;
  }
}
