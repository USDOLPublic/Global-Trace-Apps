import 'package:usdol/app/core.dart';

class CountryCacheService extends CacheServiceInterface {
  final repo = CountryRepository();
  @override
  Future<void> initRepos() async {
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.country)) {
      Hive.registerAdapter<CountryModel>(
        CountryModelAdapter(),
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
