// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_resp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacilityRespModelAdapter extends TypeAdapter<FacilityRespModel> {
  @override
  final int typeId = 11;

  @override
  FacilityRespModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FacilityRespModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      type: fields[3] as String?,
      name: fields[4] as String?,
      address: fields[5] as String?,
      districtId: fields[6] as String?,
      provinceId: fields[7] as String?,
      countryId: fields[8] as String?,
      traderName: fields[9] as String?,
      certification: fields[10] as String?,
      oarId: fields[11] as String?,
      businessRegisterNumber: fields[12] as String?,
      chainOfCustody: fields[13] as String?,
      reconciliationStartAt: fields[14] as int?,
      reconciliationDuration: fields[15] as String?,
      deletedAt: fields[16] as int?,
      users: (fields[17] as List?)?.cast<FacilityUser>(),
      farmGroupId: fields[18] as String?,
      farmId: fields[19] as String?,
      country: fields[22] as CountryModel?,
      district: fields[20] as DistrictModel?,
      province: fields[21] as ProvinceModel?,
      typeId: fields[23] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FacilityRespModel obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.districtId)
      ..writeByte(7)
      ..write(obj.provinceId)
      ..writeByte(8)
      ..write(obj.countryId)
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
      ..write(obj.users)
      ..writeByte(18)
      ..write(obj.farmGroupId)
      ..writeByte(19)
      ..write(obj.farmId)
      ..writeByte(20)
      ..write(obj.district)
      ..writeByte(21)
      ..write(obj.province)
      ..writeByte(22)
      ..write(obj.country)
      ..writeByte(23)
      ..write(obj.typeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacilityRespModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FacilityUserAdapter extends TypeAdapter<FacilityUser> {
  @override
  final int typeId = 12;

  @override
  FacilityUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FacilityUser(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      email: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      firstName: fields[5] as String?,
      lastName: fields[6] as String?,
      status: fields[7] as int?,
      lastLoginAt: fields[8] as int?,
      deletedAt: fields[9] as int?,
      joinedAt: fields[10] as int?,
      updatedProfileAt: fields[11] as int?,
      answeredSaqAt: fields[12] as int?,
      addedPartnerAt: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FacilityUser obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.firstName)
      ..writeByte(6)
      ..write(obj.lastName)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.lastLoginAt)
      ..writeByte(9)
      ..write(obj.deletedAt)
      ..writeByte(10)
      ..write(obj.joinedAt)
      ..writeByte(11)
      ..write(obj.updatedProfileAt)
      ..writeByte(12)
      ..write(obj.answeredSaqAt)
      ..writeByte(13)
      ..write(obj.addedPartnerAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacilityUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
