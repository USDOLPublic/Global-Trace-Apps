import 'package:usdol/app/core.dart';

class TransportPartnerCacheService extends CacheServiceInterface {
  final repo = TransportPartnerRepo();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.transportPartner)) {
      Hive.registerAdapter<TransportPartner>(
        TransportPartnerAdapter(),
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
