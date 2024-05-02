// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryTransactionAdapter extends TypeAdapter<HistoryTransaction> {
  @override
  final int typeId = 41;

  @override
  HistoryTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryTransaction(
      totalWeight: fields[1] as double?,
      id: fields[0] as String?,
      createdAt: fields[2] as int?,
      updatedAt: fields[3] as int?,
      fromFacilityId: fields[4] as String?,
      toFacilityId: fields[5] as String?,
      price: fields[6] as double?,
      currency: fields[7] as String?,
      weightUnit: fields[8] as String?,
      purchaseOrderNumber: fields[9] as String?,
      invoiceNumber: fields[10] as String?,
      packingListNumber: fields[11] as String?,
      transactedAt: fields[12] as int?,
      uploadProofs: (fields[13] as List?)?.cast<FileAttachmentModel>(),
      uploadInvoices: (fields[14] as List?)?.cast<FileAttachmentModel>(),
      uploadPackingLists: (fields[15] as List?)?.cast<FileAttachmentModel>(),
      creatorId: fields[16] as String?,
      deletedAt: fields[17] as int?,
      toFacility: fields[18] as FacilityModel?,
      fromFacility: fields[19] as FacilityModel?,
      transactionItems: (fields[20] as List?)?.cast<TransactionItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, HistoryTransaction obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.totalWeight)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.fromFacilityId)
      ..writeByte(5)
      ..write(obj.toFacilityId)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.currency)
      ..writeByte(8)
      ..write(obj.weightUnit)
      ..writeByte(9)
      ..write(obj.purchaseOrderNumber)
      ..writeByte(10)
      ..write(obj.invoiceNumber)
      ..writeByte(11)
      ..write(obj.packingListNumber)
      ..writeByte(12)
      ..write(obj.transactedAt)
      ..writeByte(13)
      ..write(obj.uploadProofs)
      ..writeByte(14)
      ..write(obj.uploadInvoices)
      ..writeByte(15)
      ..write(obj.uploadPackingLists)
      ..writeByte(16)
      ..write(obj.creatorId)
      ..writeByte(17)
      ..write(obj.deletedAt)
      ..writeByte(18)
      ..write(obj.toFacility)
      ..writeByte(19)
      ..write(obj.fromFacility)
      ..writeByte(20)
      ..write(obj.transactionItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryTransaction _$HistoryTransactionFromJson(Map<String, dynamic> json) =>
    HistoryTransaction(
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      fromFacilityId: json['fromFacilityId'] as String?,
      toFacilityId: json['toFacilityId'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      weightUnit: json['weightUnit'] as String?,
      purchaseOrderNumber: json['purchaseOrderNumber'] as String?,
      invoiceNumber: json['invoiceNumber'] as String?,
      packingListNumber: json['packingListNumber'] as String?,
      transactedAt: json['transactedAt'] as int?,
      uploadProofs: (json['uploadProofs'] as List<dynamic>?)
          ?.map((e) => FileAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      uploadInvoices: (json['uploadInvoices'] as List<dynamic>?)
          ?.map((e) => FileAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      uploadPackingLists: (json['uploadPackingLists'] as List<dynamic>?)
          ?.map((e) => FileAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      creatorId: json['creatorId'] as String?,
      deletedAt: json['deletedAt'] as int?,
      toFacility: json['toFacility'] == null
          ? null
          : FacilityModel.fromJson(json['toFacility'] as Map<String, dynamic>),
      fromFacility: json['fromFacility'] == null
          ? null
          : FacilityModel.fromJson(
              json['fromFacility'] as Map<String, dynamic>),
      transactionItems: (json['transactionItems'] as List<dynamic>?)
          ?.map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryTransactionToJson(HistoryTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalWeight': instance.totalWeight,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'fromFacilityId': instance.fromFacilityId,
      'toFacilityId': instance.toFacilityId,
      'price': instance.price,
      'currency': instance.currency,
      'weightUnit': instance.weightUnit,
      'purchaseOrderNumber': instance.purchaseOrderNumber,
      'invoiceNumber': instance.invoiceNumber,
      'packingListNumber': instance.packingListNumber,
      'transactedAt': instance.transactedAt,
      'uploadProofs': instance.uploadProofs,
      'uploadInvoices': instance.uploadInvoices,
      'uploadPackingLists': instance.uploadPackingLists,
      'creatorId': instance.creatorId,
      'deletedAt': instance.deletedAt,
      'toFacility': instance.toFacility,
      'fromFacility': instance.fromFacility,
      'transactionItems': instance.transactionItems,
    };
