import 'package:usdol/app/core.dart';

class UserCacheService extends CacheServiceInterface {
  final userRepo = UserRepository();
  @override
  Future<void> initRepos() async {
    if (!Hive.isBoxOpen(ModelTypeDefine.permissionBox)) {
      await Hive.openBox<UserPermission>(ModelTypeDefine.permissionBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.roleBox)) {
      await Hive.openBox<UserRole>(ModelTypeDefine.roleBox);
    }

    if (!Hive.isBoxOpen(ModelTypeDefine.countryBox)) {
      await Hive.openBox<CountryModel>(ModelTypeDefine.countryBox);
    }

    if (!Hive.isBoxOpen(ModelTypeDefine.provinceBox)) {
      await Hive.openBox<ProvinceModel>(ModelTypeDefine.provinceBox);
    }

    if (!Hive.isBoxOpen(ModelTypeDefine.districtBox)) {
      await Hive.openBox<DistrictModel>(ModelTypeDefine.districtBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.riskModelBox)) {
      await Hive.openBox<Risk>(ModelTypeDefine.riskModelBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.riskDataBox)) {
      await Hive.openBox<RiskData>(ModelTypeDefine.riskDataBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.subIndicatorRiskBox)) {
      await Hive.openBox<SubIndicatorRiskData>(
          ModelTypeDefine.subIndicatorRiskBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.sourceRiskDataBox)) {
      await Hive.openBox<SourceRiskData>(ModelTypeDefine.sourceRiskDataBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.indicatorRiskDataBox)) {
      await Hive.openBox<IndicatorRiskData>(
          ModelTypeDefine.indicatorRiskDataBox);
    }

    if (!Hive.isBoxOpen(ModelTypeDefine.dataRiskDataModelBox)) {
      await Hive.openBox<DataRiskDataModel>(
          ModelTypeDefine.dataRiskDataModelBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.facilityModel)) {
      await Hive.openBox<FacilityModel>(ModelTypeDefine.facilityModel);
    }
    await userRepo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.userPermission)) {
      Hive.registerAdapter<UserPermission>(
        UserPermissionAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.userRole)) {
      Hive.registerAdapter<UserRole>(
        UserRoleAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.country)) {
      Hive.registerAdapter<CountryModel>(
        CountryModelAdapter(),
      );
    }

    if (!Hive.isAdapterRegistered(ModelTypeDefine.province)) {
      Hive.registerAdapter<ProvinceModel>(
        ProvinceModelAdapter(),
      );
    }

    if (!Hive.isAdapterRegistered(ModelTypeDefine.district)) {
      Hive.registerAdapter<DistrictModel>(
        DistrictModelAdapter(),
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.riskModel)) {
      Hive.registerAdapter<Risk>(
        RiskAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.riskData)) {
      Hive.registerAdapter<RiskData>(
        RiskDataAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.sourceRiskData)) {
      Hive.registerAdapter<SourceRiskData>(
        SourceRiskDataAdapter(),
        override: true,
      );
    }
        if (!Hive.isAdapterRegistered(ModelTypeDefine.subIndicatorRisk)) {
      Hive.registerAdapter<SubIndicatorRiskData>(
        SubIndicatorRiskDataAdapter(),
        override: true,
      );
    }

    if (!Hive.isAdapterRegistered(ModelTypeDefine.indicatorRiskData)) {
      Hive.registerAdapter<IndicatorRiskData>(
        IndicatorRiskDataAdapter(),
        override: true,
      );
    }

    if (!Hive.isAdapterRegistered(ModelTypeDefine.dataRiskDataModel)) {
      Hive.registerAdapter<DataRiskDataModel>(
        DataRiskDataModelAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.facility)) {
      Hive.registerAdapter<FacilityModel>(
        FacilityModelAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.user)) {
      Hive.registerAdapter<UserModel>(
        UserModelAdapter(),
        override: true,
      );
    }
  }

  @override
  Future<void> dispose() async {
    await userRepo.dispose();
    return super.dispose();
  }
}
