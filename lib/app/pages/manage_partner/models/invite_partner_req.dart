class InvitePartnerReq {
  InvitePartnerReq({
    this.userInformation,
    this.facilityId,
    this.facilityInformation,
    this.transporterInformation,
    this.brokerInformation,
    this.partnerInformation,
    this.partners,
    this.isEnableEdit = true,
  });

  UserInformationReq? userInformation;
  String? facilityId;
  FacilityInformation? facilityInformation;
  TransporterInformation? transporterInformation;
  PartnerInformation? partnerInformation;
  BrokerInformation? brokerInformation;
  List<InvitePartnerReq>? partners;
  bool isEnableEdit = true;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userInformation != null) {
      map['userInformation'] = userInformation?.toJson();
    }
    if (facilityId != null) {
      map['facilityId'] = facilityId;
    }
    if (transporterInformation != null) {
      map['transporterInformation'] = transporterInformation?.toJson();
    }
    if (brokerInformation != null) {
      map['brokerInformation'] = brokerInformation?.toJson();
    }
    if (facilityInformation != null) {
      map['facilityInformation'] = facilityInformation?.toJson();
    }
    if (partnerInformation != null) {
      map['partnerInformation'] = partnerInformation?.toJson();
    }
    if (partners != null) {
      map['partners'] = partners!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  String? getBusinessName() {
    return partnerInformation?.businessName;
  }
}

class UserInformationReq {
  String? email;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  UserInformationReq({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (lastName != null) {
      map['lastName'] = lastName;
    }
    if (firstName != null) {
      map['firstName'] = firstName;
    }
    if (email != null) {
      map['email'] = email;
    }
    if (phoneNumber != null) {
      map['phoneNumber'] = phoneNumber;
    }
    return map;
  }
}

class BrokerInformation {
  BrokerInformation({
    this.businessName,
    this.address,
    this.districtId,
    this.provinceId,
    this.countryId,
    this.businessRegisterNumber,
  });

  String? businessName;
  String? address;
  String? districtId;
  String? provinceId;
  String? countryId;
  String? businessRegisterNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = businessName;
    map['districtId'] = districtId;
    map['provinceId'] = provinceId;
    map['countryId'] = countryId;
    if (address != null) {
      map['address'] = address;
    }
    if (businessRegisterNumber != null) {
      map['businessRegisterNumber'] = businessRegisterNumber;
    }
    return map;
  }
}

class TransporterInformation {
  TransporterInformation({
    this.businessName,
    this.address,
    this.districtId,
    this.provinceId,
    this.countryId,
    this.businessRegisterNumber,
  });

  String? businessName;
  String? address;
  String? districtId;
  String? provinceId;
  String? countryId;
  String? businessRegisterNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = businessName;
    if (address != null) {
      map['address'] = address;
    }
    map['districtId'] = districtId;
    map['provinceId'] = provinceId;
    map['countryId'] = countryId;
    if (businessRegisterNumber != null) {
      map['businessRegisterNumber'] = businessRegisterNumber;
    }
    return map;
  }
}

class PartnerInformation {
  PartnerInformation({
    this.businessName,
    this.districtId,
    this.provinceId,
    this.countryId,
    this.roleId,
  });

  String? businessName;
  String? districtId;
  String? provinceId;
  String? countryId;
  String? roleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = businessName;
    map['districtId'] = districtId;
    map['provinceId'] = provinceId;
    map['countryId'] = countryId;
    if (roleId != null) {
      map['roleId'] = roleId;
    }
    return map;
  }
}

class FacilityInformation {
  FacilityInformation({
    this.businessName,
    this.roleId,
  });

  String? roleId;
  String? businessName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = businessName;
    map['roleId'] = roleId;
    return map;
  }
}
