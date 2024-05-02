import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'facility_model.g.dart';

@HiveType(typeId: ModelTypeDefine.facility)
@JsonSerializable()
class FacilityModel {
  FacilityModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.address,
    this.country,
    this.district,
    this.province,
    this.traderName,
    this.certification,
    this.oarId,
    this.businessRegisterNumber,
    this.chainOfCustody,
    this.reconciliationStartAt,
    this.reconciliationDuration,
    this.deletedAt,
    this.countryId,
    this.districtId,
    this.provinceId,
    this.additionalInformation,
    this.additionalRole,
    this.facilityGroupFileId,
    this.farmId,
    this.goods,
    this.logo,
    this.overallRiskLevel,
    this.overallRiskScore,
    this.typeId,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? typeId;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? address;
  @HiveField(6)
  DistrictModel? district;
  @HiveField(7)
  ProvinceModel? province;
  @HiveField(8)
  CountryModel? country;
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
  String? districtId;
  @HiveField(18)
  String? provinceId;
  @HiveField(19)
  String? countryId;
  @HiveField(20)
  String? logo;
  @HiveField(21)
  double? overallRiskScore;
  @HiveField(22)
  String? overallRiskLevel;
  @HiveField(23)
  dynamic additionalRole;
  @HiveField(24)
  String? facilityGroupFileId;
  @HiveField(25)
  String? farmId;
  @HiveField(26)
  dynamic additionalInformation;
  @HiveField(27)
  List<String>? goods;

  factory FacilityModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityModelToJson(this);

  String get reconciliationDurationValue {
    return reconciliationDuration ?? '';
  }

  String get reconciliationDurationDisplay {
    String durationKey = reconciliationDurationValue;
    return reconciliationDurationsDef
            .firstWhereOrNull((element) => element.value == durationKey)
            ?.displayLabel ??
        "";
  }

  String get countryDisplayName => country?.country ?? '';
  String get districtDisplayName => district?.district ?? '';
  String get provinceDisplayName => province?.province ?? '';

  String getChainOfCustodyDisplayValue() {
    if (chainOfCustody == massBalanceDef.value) {
      return massBalanceDef.displayLabel;
    } else if (chainOfCustody == productSegregationDef.value) {
      return productSegregationDef.displayLabel;
    }
    return '';
  }

  bool isMassBalance() {
    return (chainOfCustody == massBalanceDef.value);
  }

  String getFullAddress() {
    if (countryId == otherCountry.id) {
      return address ?? '';
    }
    List<String> addressAttributes = [];
    if (address != null) {
      addressAttributes.add(address!);
    }
    if (districtDisplayName.isNotEmpty) {
      addressAttributes.add(districtDisplayName);
    }
    if (provinceDisplayName.isNotEmpty) {
      addressAttributes.add(provinceDisplayName);
    }
    if (countryDisplayName.isNotEmpty) {
      addressAttributes.add(countryDisplayName);
    }
    return addressAttributes.join(', ');
  }
}
