import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@HiveType(typeId: ModelTypeDefine.user)
@JsonSerializable()
class UserModel extends HiveObject {
  @HiveField(0)
  String id;
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
  int? lastLoginAt;
  @HiveField(8)
  int? deletedAt;
  @HiveField(9)
  List<UserPermission>? permissions;
  @HiveField(10)
  UserRole? role;
  @HiveField(11)
  String? roleId;
  @HiveField(12)
  int? status;
  @HiveField(13)
  int? joinedAt;
  @HiveField(14)
  int? updatedProfileAt;
  @HiveField(15)
  int? answeredSaqAt;
  @HiveField(16)
  int? addedPartnerAt;
  @HiveField(17)
  int? finishedGuidanceAt;
  @HiveField(18)
  FacilityModel? currentFacility;
  @HiveField(19)
  int? completedConfiguringSystemAt;

  UserModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.lastLoginAt,
    this.deletedAt,
    this.permissions,
    this.role,
    this.roleId,
    this.status,
    this.joinedAt,
    this.updatedProfileAt,
    this.answeredSaqAt,
    this.addedPartnerAt,
    this.finishedGuidanceAt,
    this.currentFacility,
    this.completedConfiguringSystemAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  bool isMobileSupported() {
    return true;
  }

  bool get isCompletedProfile =>
      updatedProfileAt != null && updatedProfileAt != 0;

  bool get isGinnerFarmCompleteOnboard =>
      updatedProfileAt != null &&
      updatedProfileAt != 0 &&
      addedPartnerAt != null &&
      addedPartnerAt != 0 &&
      answeredSaqAt != null &&
      answeredSaqAt != 0;

  bool isMassBalance() {
    if (getChainOfCustody() == massBalanceDef.value) {
      return true;
    }
    return false;
  }

  bool isCompletedTutorial() {
    return finishedGuidanceAt != null && finishedGuidanceAt! > 0;
  }

  bool hasPermission(String permissionName) {
    return role?.permissions
            ?.any((permission) => permission.action == permissionName) ??
        false;
  }

  bool hasRoleTypes(String roleType) {
    if (role?.type == null) return false;
    return role?.type?.toLowerCase() == roleType.toLowerCase();
  }

  bool isProductUser() {
    return hasRoleTypes(RoleTypeDef.product);
  }

  bool isLaborUser() {
    return hasRoleTypes(RoleTypeDef.labor);
  }

  bool isAdministrator() {
    return hasRoleTypes(RoleTypeDef.administrator);
  }

  bool isSupperAdmin() {
    String? roleName = role?.name?.toLowerCase();
    return isAdministrator() &&
        roleName == RoleNameDef.superAdmin.toLowerCase();
  }

  String? getChainOfCustody() {
    if (currentFacility?.chainOfCustody != null) {
      return currentFacility?.chainOfCustody;
    }
    return role?.chainOfCustody;
  }
}
