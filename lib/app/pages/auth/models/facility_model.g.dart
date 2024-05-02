// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacilityModelAdapter extends TypeAdapter<FacilityModel> {
  @override
  final int typeId = 6;

  @override
  FacilityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FacilityModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      name: fields[4] as String?,
      address: fields[5] as String?,
      country: fields[8] as CountryModel?,
      district: fields[6] as DistrictModel?,
      province: fields[7] as ProvinceModel?,
      traderName: fields[9] as String?,
      certification: fields[10] as String?,
      oarId: fields[11] as String?,
      businessRegisterNumber: fields[12] as String?,
      chainOfCustody: fields[13] as String?,
      reconciliationStartAt: fields[14] as int?,
      reconciliationDuration: fields[15] as String?,
      deletedAt: fields[16] as int?,
      countryId: fields[19] as String?,
      districtId: fields[17] as String?,
      provinceId: fields[18] as String?,
      additionalInformation: fields[26] as dynamic,
      additionalRole: fields[23] as dynamic,
      facilityGroupFileId: fields[24] as String?,
      farmId: fields[25] as String?,
      goods: (fields[27] as List?)?.cast<String>(),
      logo: fields[20] as String?,
      overallRiskLevel: fields[22] as String?,
      overallRiskScore: fields[21] as double?,
      typeId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FacilityModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.typeId)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.district)
      ..writeByte(7)
      ..write(obj.province)
      ..writeByte(8)
      ..write(obj.country)
      ..writeByte(9)
      ..write(obj.traderName)
      ..writeByte(10)
      ..write(obj.certification)
      ..writeByte(11)
      ..write(obj.oarId)
      ..writeByte(12)
      ..write(obj.businessRegisterNumber)
      ..writeByte(13)
      ..write(obj.chainOfCustody)
      ..writeByte(14)
      ..write(obj.reconciliationStartAt)
      ..writeByte(15)
      ..write(obj.reconciliationDuration)
      ..writeByte(16)
      ..write(obj.deletedAt)
      ..writeByte(17)
      ..write(obj.districtId)
      ..writeByte(18)
      ..write(obj.provinceId)
      ..writeByte(19)
      ..write(obj.countryId)
      ..writeByte(20)
      ..write(obj.logo)
      ..writeByte(21)
      ..write(obj.overallRiskScore)
      ..writeByte(22)
      ..write(obj.overallRiskLevel)
      ..writeByte(23)
      ..write(obj.additionalRole)
      ..writeByte(24)
      ..write(obj.facilityGroupFileId)
      ..writeByte(25)
      ..write(obj.farmId)
      ..writeByte(26)
      ..write(obj.additionalInformation)
      ..writeByte(27)
      ..write(obj.goods);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacilityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityModel _$FacilityModelFromJson(Map<String, dynamic> json) =>
    FacilityModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      country: json['country'] == null
          ? null
          : CountryModel.fromJson(json['country'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      province: json['province'] == null
          ? null
          : ProvinceModel.fromJson(json['province'] as Map<String, dynamic>),
      traderName: json['traderName'] as String?,
      certification: json['certification'] as String?,
      oarId: json['oarId'] as String?,
      businessRegisterNumber: json['businessRegisterNumber'] as String?,
      chainOfCustody: json['chainOfCustody'] as String?,
      reconciliationStartAt: json['reconciliationStartAt'] as int?,
      reconciliationDuration: json['reconciliationDuration'] as String?,
      deletedAt: json['deletedAt'] as int?,
      countryId: json['countryId'] as String?,
      districtId: json['districtId'] as String?,
      provinceId: json['provinceId'] as String?,
      additionalInformation: json['additionalInformation'],
      additionalRole: json['additionalRole'],
      facilityGroupFileId: json['facilityGroupFileId'] as String?,
      farmId: json['farmId'] as String?,
      goods:
          (json['goods'] as List<dynamic>?)?.map((e) => e as String).toList(),
      logo: json['logo'] as String?,
      overallRiskLevel: json['overallRiskLevel'] as String?,
      overallRiskScore: (json['overallRiskScore'] as num?)?.toDouble(),
      typeId: json['typeId'] as String?,
    );

Map<String, dynamic> _$FacilityModelToJson(FacilityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'typeId': instance.typeId,
      'name': instance.name,
      'address': instance.address,
      'district': instance.district,
      'province': instance.province,
      'country': instance.country,
      'traderName': instance.traderName,
      'certification': instance.certification,
      'oarId': instance.oarId,
      'businessRegisterNumber': instance.businessRegisterNumber,
      'chainOfCustody': instance.chainOfCustody,
      'reconciliationStartAt': instance.reconciliationStartAt,
      'reconciliationDuration': instance.reconciliationDuration,
      'deletedAt': instance.deletedAt,
      'districtId': instance.districtId,
      'provinceId': instance.provinceId,
      'countryId': instance.countryId,
      'logo': instance.logo,
      'overallRiskScore': instance.overallRiskScore,
      'overallRiskLevel': instance.overallRiskLevel,
      'additionalRole': instance.additionalRole,
      'facilityGroupFileId': instance.facilityGroupFileId,
      'farmId': instance.farmId,
      'additionalInformation': instance.additionalInformation,
      'goods': instance.goods,
    };
