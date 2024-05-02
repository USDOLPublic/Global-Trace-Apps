import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_resp.g.dart';

@JsonSerializable()
class RegisterResp extends BaseObject {
  RegisterResp({
    this.id,
    this.createdAt,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.lastLoginAt,
    this.deletedAt,
    this.updatedAt,
  });

  String? id;
  int? createdAt;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  int? lastLoginAt;
  int? deletedAt;
  int? updatedAt;

  factory RegisterResp.fromJson(Map<String, dynamic> json) =>
      _$RegisterRespFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRespToJson(this);
}
