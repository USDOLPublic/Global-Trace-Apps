import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_permission.g.dart';

@HiveType(typeId: ModelTypeDefine.userPermission)
@JsonSerializable()
class UserPermission extends HiveObject {
  UserPermission({
    this.id,
    this.name,
    this.action,
    this.groupType,
    this.groups,
    this.label,
    this.sortOrder,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? action;
  @HiveField(3)
  int? sortOrder;
  @HiveField(4)
  String? label;
  @HiveField(5)
  String? groups;
  @HiveField(6)
  String? groupType;

  factory UserPermission.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionFromJson(json);

  Map<String, dynamic> toJson() => _$UserPermissionToJson(this);

  bool isUserPermission() {
    return action?.split('/').first == "user";
  }

  bool isTradingPermission() {
    return action?.split('/').first == "trading";
  }

  bool isAuthPermission() {
    return action?.split('/').first == "auth";
  }

  bool isHaveAction(String actionKey) {
    return action?.split('/').last == actionKey;
  }

  String getActionKey() {
    return action?.split('/').last ?? "";
  }
}
