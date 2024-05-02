import 'package:usdol/app/core.dart';

class SellPartnerCacheService extends CacheServiceInterface {
  final repo = SellPartnerRepo();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.sellPartner)) {
      Hive.registerAdapter<SellPartner>(
        SellPartnerAdapter(),
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
