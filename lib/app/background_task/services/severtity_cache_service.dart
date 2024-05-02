import 'package:usdol/app/core.dart';

class SeverityCacheService extends CacheServiceInterface {
  final repo = SeverityRepository();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.severity)) {
      Hive.registerAdapter<SeverityModel>(
        SeverityModelAdapter(),
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
