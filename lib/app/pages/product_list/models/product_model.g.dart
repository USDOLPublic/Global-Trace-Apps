// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 60;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String?,
      createdAt: fields[1] as int?,
      updatedAt: fields[2] as int?,
      productDefinitionId: fields[3] as String?,
      code: fields[4] as String?,
      dnaIdentifier: fields[5] as String?,
      verifiedPercentage: fields[6] as double?,
      notVerifiedPercentage: fields[7] as double?,
      isPurchased: fields[8] as bool?,
      isSold: fields[9] as bool?,
      isTransformed: fields[10] as bool?,
      isTransported: fields[11] as bool?,
      isManualAdded: fields[12] as bool?,
      additionalAttributes:
          (fields[13] as List?)?.cast<AdditionalAttributeModel>(),
      createdFacilityId: fields[14] as String?,
      certifications: (fields[15] as List?)?.cast<FileAttachmentModel>(),
      quantity: fields[16] as double?,
      quantityUnit: fields[17] as String?,
      isHavingCertification: fields[18] as bool?,
      productDefinition: fields[19] as ProductDefinitionModel?,
      qrCode: fields[20] as QrCodeModel?,
      manualAdded: fields[21] as ManualAddedProductRequest?,
      isAddByManualForm: fields[22] as bool,
      productCodeManual: fields[23] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.productDefinitionId)
      ..writeByte(4)
      ..write(obj.code)
      ..writeByte(5)
      ..write(obj.dnaIdentifier)
      ..writeByte(6)
      ..write(obj.verifiedPercentage)
      ..writeByte(7)
      ..write(obj.notVerifiedPercentage)
      ..writeByte(8)
      ..write(obj.isPurchased)
      ..writeByte(9)
      ..write(obj.isSold)
      ..writeByte(10)
      ..write(obj.isTransformed)
      ..writeByte(11)
      ..write(obj.isTransported)
      ..writeByte(12)
      ..write(obj.isManualAdded)
      ..writeByte(13)
      ..write(obj.additionalAttributes)
      ..writeByte(14)
      ..write(obj.createdFacilityId)
      ..writeByte(15)
      ..write(obj.certifications)
      ..writeByte(16)
      ..write(obj.quantity)
      ..writeByte(17)
      ..write(obj.quantityUnit)
      ..writeByte(18)
      ..write(obj.isHavingCertification)
      ..writeByte(19)
      ..write(obj.productDefinition)
      ..writeByte(20)
      ..write(obj.qrCode)
      ..writeByte(21)
      ..write(obj.manualAdded)
      ..writeByte(22)
      ..write(obj.isAddByManualForm)
      ..writeByte(23)
      ..write(obj.productCodeManual);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      productDefinitionId: json['productDefinitionId'] as String?,
      code: json['code'] as String?,
      dnaIdentifier: json['dnaIdentifier'] as String?,
      verifiedPercentage: (json['verifiedPercentage'] as num?)?.toDouble(),
      notVerifiedPercentage:
          (json['notVerifiedPercentage'] as num?)?.toDouble(),
      isPurchased: json['isPurchased'] as bool?,
      isSold: json['isSold'] as bool?,
      isTransformed: json['isTransformed'] as bool?,
      isTransported: json['isTransported'] as bool?,
      isManualAdded: json['isManualAdded'] as bool?,
      additionalAttributes: (json['additionalAttributes'] as List<dynamic>?)
          ?.map((e) =>
              AdditionalAttributeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdFacilityId: json['createdFacilityId'] as String?,
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map((e) => FileAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      quantityUnit: json['quantityUnit'] as String?,
      isHavingCertification: json['isHavingCertification'] as bool?,
      productDefinition: json['productDefinition'] == null
          ? null
          : ProductDefinitionModel.fromJson(
              json['productDefinition'] as Map<String, dynamic>),
      qrCode: json['qrCode'] == null
          ? null
          : QrCodeModel.fromJson(json['qrCode'] as Map<String, dynamic>),
      manualAdded: json['manualAdded'] == null
          ? null
          : ManualAddedProductRequest.fromJson(
              json['manualAdded'] as Map<String, dynamic>),
      isAddByManualForm: json['isAddByManualForm'] as bool? ?? false,
      productCodeManual: json['productCodeManual'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'productDefinitionId': instance.productDefinitionId,
      'code': instance.code,
      'dnaIdentifier': instance.dnaIdentifier,
      'verifiedPercentage': instance.verifiedPercentage,
      'notVerifiedPercentage': instance.notVerifiedPercentage,
      'isPurchased': instance.isPurchased,
      'isSold': instance.isSold,
      'isTransformed': instance.isTransformed,
      'isTransported': instance.isTransported,
      'isManualAdded': instance.isManualAdded,
      'additionalAttributes': instance.additionalAttributes,
      'createdFacilityId': instance.createdFacilityId,
      'certifications': instance.certifications,
      'quantity': instance.quantity,
      'quantityUnit': instance.quantityUnit,
      'isHavingCertification': instance.isHavingCertification,
      'productDefinition': instance.productDefinition,
      'qrCode': instance.qrCode,
      'manualAdded': instance.manualAdded,
      'isAddByManualForm': instance.isAddByManualForm,
      'productCodeManual': instance.productCodeManual,
    };
