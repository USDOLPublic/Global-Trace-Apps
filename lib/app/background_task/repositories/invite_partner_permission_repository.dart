import 'package:usdol/app/core.dart';

class InvitePartnerPermissionRepository
    extends ActiveRepo<String, InvitePartnerPermission> {
  @override
  String get boxName => ModelTypeDefine.invitePartnerPerBox;

  List<InvitePartnerPermission> getListValue() {
    Map<String, InvitePartnerPermission> permissions = getAllValues();
    return permissions.values.toList();
  }
}
