import 'package:usdol/app/core.dart';

class PurchasePartnerCacheService extends CacheServiceInterface {
  final repo = PurchasePartnerRepo();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.purchasePartner)) {
      Hive.registerAdapter<PurchasePartner>(
        PurchasePartnerAdapter(),
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
