class OarIdReqModel {
  OarIdReqModel({
    this.countryId,
    this.address,
    this.name,
    this.provinceId,
    this.districtId,
    this.countryName,
    this.districtName,
    this.provinceName,
  });

  OarIdReqModel.fromJson(dynamic json) {
    countryId = (json['countryId'] ?? '').toString();
    provinceId = (json['provinceId'] ?? '').toString();
    districtId = (json['districtId'] ?? '').toString();
    address = (json['address'] ?? '').toString();
    name = (json['name'] ?? '').toString();
  }

  String? countryId;
  String? provinceId;
  String? districtId;
  String? countryName;
  String? provinceName;
  String? districtName;
  String? address;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['countryId'] = countryId;
    map['provinceId'] = provinceId;
    map['districtId'] = districtId;
    map['address'] = address;
    map['name'] = name;
    return map;
  }
}
