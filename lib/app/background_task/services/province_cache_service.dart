import 'package:usdol/app/core.dart';

class ProvinceCacheService extends CacheServiceInterface {
  final repo = ProvinceRepository();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.province)) {
      Hive.registerAdapter<ProvinceModel>(
        ProvinceModelAdapter(),
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
