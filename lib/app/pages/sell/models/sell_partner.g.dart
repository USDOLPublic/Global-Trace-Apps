// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_partner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SellPartnerAdapter extends TypeAdapter<SellPartner> {
  @override
  final int typeId = 7;

  @override
  SellPartner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SellPartner(
      id: fields[0] as String,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      type: fields[3] as String?,
      name: fields[4] as String?,
      address: fields[5] as String?,
      district: fields[6] as String?,
      province: fields[7] as String?,
      country: fields[8] as String?,
      traderName: fields[9] as String?,
      certification: fields[10] as String?,
      oarId: fields[11] as String?,
      businessRegisterNumber: fields[12] as String?,
      reconciliationStartAt: fields[13] as int?,
      reconciliationDuration: fields[14] as String?,
      deletedAt: fields[15] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SellPartner obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.reconciliationStartAt)
      ..writeByte(14)
      ..write(obj.reconciliationDuration)
      ..writeByte(15)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellPartnerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
