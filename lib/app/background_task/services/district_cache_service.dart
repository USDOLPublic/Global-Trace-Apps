import 'package:usdol/app/core.dart';

class DistrictCacheService extends CacheServiceInterface {
  final repo = DistrictRepository();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.district)) {
      Hive.registerAdapter<DistrictModel>(
        DistrictModelAdapter(),
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
