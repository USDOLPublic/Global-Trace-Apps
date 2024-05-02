import 'package:usdol/app/core.dart';

class IndicatorCacheService extends CacheServiceInterface {
  final repo = IndicatorRepository();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.indicator)) {
      Hive.registerAdapter<IndicatorModel>(
        IndicatorModelAdapter(),
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
