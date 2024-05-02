import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_information_model.g.dart';

@HiveType(typeId: ModelTypeDefine.requestInformation)
@JsonSerializable()
class RequestInformationModel {
  RequestInformationModel({
    this.id,
    this.createdAt,
    this.recordedAt,
    this.updatedAt,
    this.facilityId,
    this.location,
    this.message,
    this.laborRisks,
    this.assigneeId,
    this.reason,
    this.status,
    this.latestActivityAt,
    this.assignee,
    this.facility,
    this.responses,
    this.creator,
    this.uploadFiles,
    this.auditReportNumber,
    this.creatorId,
    this.isNoFollowUp,
    this.priority,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? facilityId;
  @HiveField(4)
  String? location;
  @HiveField(5)
  String? message;
  @HiveField(6)
  List<LaborRisksResp>? laborRisks;
  @HiveField(7)
  String? assigneeId;
  @HiveField(8)
  String? reason;
  @HiveField(9)
  AssigneeModel? assignee;
  @HiveField(10)
  FacilityModel? facility;
  @HiveField(11)
  AssigneeModel? creator;
  @HiveField(12)
  List<RespondModel>? responses;
  @HiveField(13)
  int? recordedAt;
  @HiveField(14)
  String? creatorId;
  @HiveField(15)
  int? priority;
  @HiveField(16)
  bool? isNoFollowUp;
  @HiveField(17)
  dynamic auditReportNumber;
  @HiveField(18)
  List<String>? uploadFiles;
  @HiveField(19)
  int? latestActivityAt;
  @HiveField(20)
  int? status;

  factory RequestInformationModel.fromJson(Map<String, dynamic> json) =>
      _$RequestInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestInformationModelToJson(this);

  String get getFacilityName =>
      (facility == null || (facility?.name?.isEmpty ?? true))
          ? (facility?.name ?? '')
          : facility!.name??'';

  String get title => status == RequestInformationEnum.admin
      ? (creator?.firstName ?? '') + ' ' + (creator?.lastName ?? '')
      : RequestInformationEnum.getTitle(status ?? 0);

  DateTime getTimeDisplay() {
    int millisecondTime = 0;
    if (recordedAt != null && recordedAt != 0) {
      millisecondTime = recordedAt!;
    } else if (createdAt != null && createdAt != 0) {
      millisecondTime = createdAt!;
    }

    if (millisecondTime != 0) {
      return DateTime.fromMillisecondsSinceEpoch((millisecondTime) * 1000);
    }

    return DateTime.now();
  }

  DateTime getCreateDate() {
    return DateTime.fromMillisecondsSinceEpoch((createdAt ?? 0) * 1000);
  }

  void addRespond(RespondModel respond) {
    responses ??= <RespondModel>[];
    RespondModel? existedResp =
        responses!.firstWhereOrNull((element) => element.id == respond.id);
    if (existedResp != null) {
      responses![responses!.indexOf(existedResp)] = respond;
    } else {
      responses!.add(respond);
    }
  }

  void addAllRespond(List<RespondModel> responds) {
    for (var item in responds) {
      addRespond(item);
    }
  }

  bool get haveResponse => (responses?.isNotEmpty ?? false);
}
