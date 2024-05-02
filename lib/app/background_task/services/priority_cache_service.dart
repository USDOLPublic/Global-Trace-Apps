import 'package:usdol/app/core.dart';

class PriorityCacheService extends CacheServiceInterface {
  final repo = PriorityRepository();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.priority)) {
      Hive.registerAdapter<PriorityModel>(
        PriorityModelAdapter(),
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
