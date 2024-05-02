import 'package:usdol/app/core.dart';

class PendingRequestCacheService extends CacheServiceInterface {
  final repo = PendingRequestRepo();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.pendingRequest)) {
      Hive.registerAdapter<PendingRequestModel>(
        PendingRequestModelAdapter(),
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
