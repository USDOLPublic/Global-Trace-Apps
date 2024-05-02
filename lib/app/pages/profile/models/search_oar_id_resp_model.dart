import 'package:usdol/app/core.dart';

class SearchOarIdRespModel {
  SearchOarIdRespModel({
    this.matches,
    this.status,
    this.oarId,
  });

  SearchOarIdRespModel.fromJson(dynamic json) {
    matches = json["matches"] == null
        ? null
        : json["matches"] is List
            ? List<OarIdResult>.from(
                (json["matches"] as List<dynamic>)
                    .map<OarIdResult?>((dynamic x) {
                  if (x is Map<String, dynamic>) {
                    return OarIdResult.fromJson(x);
                  } else {
                    return null;
                  }
                }).toList(),
              )
            : null;
    status = (json['status'] ?? '').toString();
    oarId = (json['oarId'] ?? '').toString();
  }

  List<OarIdResult>? matches;
  String? status;
  String? oarId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (matches != null) {
      map['matches'] = matches?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['oarId'] = oarId;
    return map;
  }

  bool get isMatched => status == 'MATCHED';

  bool get isNewFacility => status == 'NEW_FACILITY';

  bool get isPotential => status == 'POTENTIAL_MATCH';

  bool get isErrorData => status == 'ERROR_MATCHING';

  List<OarIdResult> getMatchedOarId() {
    return matches ?? [];
  }

  OarIdResult getOarIdResultFromRequest(OarIdReqModel req,
      {int? facilityMatchId}) {
    LogUtil.d("getOarIdResultFromRequest: $oarId");
    OarIdResult oarIdRs = OarIdResult.fromRequestCreate(req,
        oarId: oarId, facilityMatchId: facilityMatchId);
    return oarIdRs;
  }
}

class OarIdResult {
  OarIdResult({
    this.name,
    this.address,
    this.oarId,
    this.countryName,
    this.countryCode,
    this.country,
    this.province,
    this.district,
    this.facilityMatchId,
    this.countryId,
    this.districtId,
    this.provinceId,
    this.inputNewInfo,
  });

  OarIdResult.fromJson(dynamic json) {
    name = (json['name'] ?? '').toString();
    address = (json['address'] ?? '').toString();
    oarId = (json['oarId'] ?? '').toString();
    countryName = (json['countryName'] ?? '').toString();
    countryCode = (json['countryCode'] ?? '').toString();
    facilityMatchId = (json['facilityMatchId'] ?? 0) as int;
    countryId = (json['countryId'] ?? '').toString();
    provinceId = (json['provinceId'] ?? '').toString();
    districtId = (json['districtId'] ?? '').toString();
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

  String? name;
  String? address;
  String? oarId;
  String? countryName;
  String? countryCode;
  ProvinceModel? province;
  DistrictModel? district;
  CountryModel? country;
  String? countryId;
  String? provinceId;
  String? districtId;
  int? facilityMatchId;
  bool? inputNewInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['address'] = address;
    map['oarId'] = oarId;
    map['countryName'] = countryName;
    map['countryCode'] = countryCode;
    map['province'] = province;
    map['district'] = district;
    map['facilityMatchId'] = facilityMatchId;
    return map;
  }

  factory OarIdResult.fromRequestCreate(OarIdReqModel req,
      {String? oarId, int? facilityMatchId}) {
    OarIdResult oarIdRs = OarIdResult(
      name: req.name,
      oarId: oarId,
      address: req.address,
      countryName: req.countryName,
      facilityMatchId: facilityMatchId,
      countryId: req.countryId,
      districtId: req.districtId,
      provinceId: req.provinceId,
      country: CountryModel(
        id: req.countryId,
        country: req.countryName,
      ),
      province: ProvinceModel(
        id: req.provinceId,
        province: req.provinceName,
      ),
      district: DistrictModel(
        id: req.districtId,
        district: req.districtName,
      ),
    );
    return oarIdRs;
  }

  bool isOtherOption() {
    return oarId == null || oarId!.isEmpty || facilityMatchId == null;
  }

  String get countryDisplayName => country?.country ?? '';
  String get districtDisplayName => district?.district ?? '';
  String get provinceDisplayName => province?.province ?? '';
}
