import 'package:usdol/app/core.dart';

class ProfileCerCacheService extends CacheServiceInterface {
  final repository = ProfileCerRepository();

  @override
  Future<void> initRepos() async {
    await repository.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.profileCertification)) {
      Hive.registerAdapter<ProfileCerModel>(
        ProfileCerModelAdapter(),
        override: true,
      );
    }
  }

  @override
  Future<void> dispose() async {
    await repository.dispose();
    return super.dispose();
  }
}