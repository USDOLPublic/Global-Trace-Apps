import 'package:usdol/app/core.dart';

class InvitePartnerPermissionCacheService extends CacheServiceInterface {
  final repo = InvitePartnerPermissionRepository();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.invitePartnerPer)) {
      Hive.registerAdapter<InvitePartnerPermission>(
        InvitePartnerPermissionAdapter(),
        override: true,
      );
    }
  }

  @override
  Future<void> dispose() async {
    await repo.dispose();
    return super.dispose();
  }
}
