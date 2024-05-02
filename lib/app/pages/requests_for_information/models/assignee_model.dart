import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'assignee_model.g.dart';

@HiveType(typeId: ModelTypeDefine.requestInformationAssign)
@JsonSerializable()
class AssigneeModel {
  AssigneeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.status,
    this.lastLoginAt,
    this.deletedAt,
    this.joinedAt,
    this.updatedProfileAt,
    this.answeredSaqAt,
    this.latestActivityAt,
    this.addedPartnerAt,
    this.finishedGuidanceAt,
    this.roleId,
  });
  factory AssigneeModel.fromJson(Map<String, dynamic> json) =>
      _$AssigneeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssigneeModelToJson(this);

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? phoneNumber;
  @HiveField(5)
  String? firstName;
  @HiveField(6)
  String? lastName;
  @HiveField(7)
  int? status;
  @HiveField(8)
  int? lastLoginAt;
  @HiveField(9)
  int? deletedAt;
  @HiveField(10)
  int? joinedAt;
  @HiveField(11)
  int? updatedProfileAt;
  @HiveField(12)
  int? answeredSaqAt;
  @HiveField(13)
  int? latestActivityAt;
  @HiveField(14)
  int? addedPartnerAt;
  @HiveField(15)
  int? finishedGuidanceAt;
  @HiveField(16)
  String? roleId;
}
