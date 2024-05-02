import 'package:usdol/app/core.dart';

class ManagePartnerCacheService extends CacheServiceInterface {
  final ManagePartnerRepository repository = ManagePartnerRepository();

  @override
  Future<void> initRepos() async {
    await repository.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.facilityResp)) {
      Hive.registerAdapter<FacilityRespModel>(
        FacilityRespModelAdapter(),
        override: true,
      );
    }

    if (!Hive.isAdapterRegistered(ModelTypeDefine.facilityUserResp)) {
      Hive.registerAdapter<FacilityUser>(
        FacilityUserAdapter(),
        override: true,
      );
    }
  }

}