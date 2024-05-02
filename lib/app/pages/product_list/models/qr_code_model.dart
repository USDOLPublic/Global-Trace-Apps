import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'qr_code_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.qrCode)
class QrCodeModel extends HiveObject {
  QrCodeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.qrCodeBatchId,
    this.lotId,
    this.code,
    this.status,
    this.deletedAt,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? qrCodeBatchId;
  @HiveField(4)
  String? lotId;
  @HiveField(5)
  String? code;
  @HiveField(6)
  int? status;
  @HiveField(7)
  int? deletedAt;

  factory QrCodeModel.fromJson(Map<String, dynamic> json) =>
      _$QrCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$QrCodeModelToJson(this);
}
