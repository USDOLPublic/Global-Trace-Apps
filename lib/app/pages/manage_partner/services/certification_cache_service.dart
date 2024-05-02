import 'package:usdol/app/core.dart';

class CertificationCacheService extends CacheServiceInterface {
  final repository = CertificationRepository();

  @override
  Future<void> initRepos() async {
    await repository.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.certification)) {
      Hive.registerAdapter<CertificationModel>(
        CertificationModelAdapter(),
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