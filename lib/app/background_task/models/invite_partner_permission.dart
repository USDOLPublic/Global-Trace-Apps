import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'invite_partner_permission.g.dart';

@HiveType(typeId: ModelTypeDefine.invitePartnerPer)
@JsonSerializable()
class InvitePartnerPermission extends HiveObject{
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final int? createdAt;
  @HiveField(2)
  final int? updatedAt;
  @HiveField(3)
  final String? name;
  @HiveField(4)
  final String? type;
  @HiveField(5)
  final String? chainOfCustody;

  InvitePartnerPermission({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.type,
    this.chainOfCustody,
  });

  factory InvitePartnerPermission.fromJson(Map<String, dynamic> json) =>
      _$InvitePartnerPermissionFromJson(json);
}
