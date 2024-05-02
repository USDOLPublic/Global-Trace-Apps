import 'package:usdol/app/core.dart';

class UserRepository extends ActiveRepo<String, UserModel> {
  @override
  String get boxName => ModelTypeDefine.userBox;

  @override
  Future<void> clear() async {
    var userPermissionBox =
        Hive.box<UserPermission>(ModelTypeDefine.permissionBox);
    await userPermissionBox.clear();
    var userRoleBox = Hive.box<UserRole>(ModelTypeDefine.roleBox);
    await userRoleBox.clear();
    var risk = Hive.box<Risk>(ModelTypeDefine.riskModelBox);
    await risk.clear();
    var riskData = Hive.box<RiskData>(ModelTypeDefine.riskDataBox);
    await riskData.clear();
    var facility = Hive.box<FacilityModel>(ModelTypeDefine.facilityModel);
    await facility.clear();
    return super.clear();
  }
}
