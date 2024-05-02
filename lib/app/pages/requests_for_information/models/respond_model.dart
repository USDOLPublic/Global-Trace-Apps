import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'respond_model.g.dart';

@HiveType(typeId: ModelTypeDefine.requestInformationReport)
@JsonSerializable()
class RespondModel extends BaseReq {
  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? grievanceReportId;
  @HiveField(4)
  String? message;
  @HiveField(5)
  List<LaborRisksResp>? laborRisks;
  @HiveField(6)
  int? priority;
  @HiveField(7)
  int? recordedAt;
  @HiveField(8)
  List<String>? uploadImages;
  @HiveField(9)
  String? auditReportNumber;
  @HiveField(10)
  List<String>? uploadedImages;

  RespondModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.grievanceReportId,
    this.laborRisks,
    this.message,
    this.priority,
    this.recordedAt,
    this.uploadImages,
    this.uploadedImages,
    this.auditReportNumber,
  });

  factory RespondModel.fromJson(Map<String, dynamic> json) =>
      _$RespondModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RespondModelToJson(this);

  Map<String, dynamic> toRequest() {
    Map<String, dynamic> mapData = <String, dynamic>{
      'message': message,
      'laborRisks': laborRisks?.map((e) => e.toRequest()).toList(),
      'priority': priority,
      'recordedAt': recordedAt,
      'auditReportNumber': auditReportNumber,
    };
    if (uploadedImages != null && uploadedImages!.isNotEmpty) {
      mapData['uploadImages'] = uploadedImages;
    }
    return mapData;
  }

  DateTime getCreateDate() {
    return DateTime.fromMillisecondsSinceEpoch((createdAt ?? 0) * 1000);
  }

  DateTime getRecordedAt() {
    return DateTime.fromMillisecondsSinceEpoch((recordedAt ?? 0) * 1000);
  }
}
