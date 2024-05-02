import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_role.g.dart';

@HiveType(typeId: ModelTypeDefine.userRole)
@JsonSerializable()
class UserRole {
  UserRole({
    this.id,
    this.name,
    this.permissions,
    this.chainOfCustody,
    this.createdAt,
    this.type,
    this.updatedAt,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<UserPermission>? permissions;
  @HiveField(3)
  String? type;
  @HiveField(4)
  int? createdAt;
  @HiveField(5)
  int? updatedAt;
  @HiveField(6)
  String? chainOfCustody;

  factory UserRole.fromJson(Map<String, dynamic> json) =>
      _$UserRoleFromJson(json);
  Map<String, dynamic> toJson() => _$UserRoleToJson(this);
}
