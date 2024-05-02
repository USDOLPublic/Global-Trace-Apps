import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_record_product.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.historyRecordByProduct)
class HistoryRecordProduct extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  double? totalWeight;
  @HiveField(4)
  String? weightUnit;
  @HiveField(5)
  String? facilityId;
  @HiveField(6)
  int? recordedAt;
  @HiveField(7)
  List<FileAttachmentModel>? uploadProofs;

  HistoryRecordProduct({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.totalWeight,
    this.weightUnit,
    this.facilityId,
    this.recordedAt,
    this.uploadProofs,
  });

  factory HistoryRecordProduct.fromJson(Map<String, dynamic> json) =>
      _$HistoryRecordProductFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryRecordProductToJson(this);

  factory HistoryRecordProduct.fromPendingRequest(
      RecordProductRequest request) {
    return HistoryRecordProduct(
      id: const Uuid().v1(),
      totalWeight: request.totalWeight,
      weightUnit: request.weightUnit,
      recordedAt: request.recordedAt,
      uploadProofs: request.uploadProofs.map((e) {
        return FileAttachmentModel(
          fileName: FileUtil.getFileName(e),
          link: e,
        );
      }).toList(),
    );
  }
}
