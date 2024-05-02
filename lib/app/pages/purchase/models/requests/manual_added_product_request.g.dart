// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_added_product_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ManualAddedProductRequestAdapter
    extends TypeAdapter<ManualAddedProductRequest> {
  @override
  final int typeId = 65;

  @override
  ManualAddedProductRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ManualAddedProductRequest(
      code: fields[0] as String?,
      attributes: (fields[1] as List?)?.cast<AttributeRequest>(),
      isManualAdded: fields[2] as bool?,
      dnaIdentifier: fields[4] as String?,
      qrCode: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ManualAddedProductRequest obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.attributes)
      ..writeByte(2)
      ..write(obj.isManualAdded)
      ..writeByte(3)
      ..write(obj.qrCode)
      ..writeByte(4)
      ..write(obj.dnaIdentifier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ManualAddedProductRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManualAddedProductRequest _$ManualAddedProductRequestFromJson(
        Map<String, dynamic> json) =>
    ManualAddedProductRequest(
      code: json['code'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => AttributeRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      isManualAdded: json['isManualAdded'] as bool?,
      dnaIdentifier: json['dnaIdentifier'] as String?,
      qrCode: json['qrCode'] as String?,
    );

Map<String, dynamic> _$ManualAddedProductRequestToJson(
        ManualAddedProductRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'attributes': instance.attributes,
      'isManualAdded': instance.isManualAdded,
      'qrCode': instance.qrCode,
      'dnaIdentifier': instance.dnaIdentifier,
    };
