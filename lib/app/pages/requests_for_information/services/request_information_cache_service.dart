import 'package:usdol/app/core.dart';

class RequestInformationCacheService extends CacheServiceInterface {
  final repo = RequestInformationRepository();

  @override
  Future<void> initRepos() async {
    if (!Hive.isBoxOpen(ModelTypeDefine.riskModelBox)) {
      await Hive.openBox<Risk>(ModelTypeDefine.riskModelBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.facilityModel)) {
      await Hive.openBox<FacilityModel>(ModelTypeDefine.facilityModel);
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
    if (!Hive.isBoxOpen(ModelTypeDefine.riskDataBox)) {
      await Hive.openBox<RiskData>(ModelTypeDefine.riskDataBox);
    }

    if (!Hive.isBoxOpen(ModelTypeDefine.dataRiskDataModelBox)) {
      await Hive.openBox<DataRiskDataModel>(
          ModelTypeDefine.dataRiskDataModelBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.requestInformationAssignBox)) {
      await Hive.openBox<AssigneeModel>(
          ModelTypeDefine.requestInformationAssignBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.laborRiskBox)) {
      await Hive.openBox<AssigneeModel>(ModelTypeDefine.laborRiskBox);
    }
    if (!Hive.isBoxOpen(ModelTypeDefine.requestInformationReportBox)) {
      await Hive.openBox<RespondModel>(
          ModelTypeDefine.requestInformationReportBox);
    }
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.riskModel)) {
      Hive.registerAdapter<Risk>(
        RiskAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.sourceRiskData)) {
      Hive.registerAdapter<SourceRiskData>(
        SourceRiskDataAdapter(),
        override: true,
      );
    }

    if (!Hive.isAdapterRegistered(ModelTypeDefine.indicatorRiskData)) {
      Hive.registerAdapter<IndicatorRiskData>(
        IndicatorRiskDataAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.riskData)) {
      Hive.registerAdapter<RiskData>(
        RiskDataAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.dataRiskDataModel)) {
      Hive.registerAdapter<DataRiskDataModel>(
        DataRiskDataModelAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.requestInformationAssign)) {
      Hive.registerAdapter<AssigneeModel>(
        AssigneeModelAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.laborRisk)) {
      Hive.registerAdapter<LaborRisksResp>(
        LaborRisksRespAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.facility)) {
      Hive.registerAdapter<FacilityModel>(
        FacilityModelAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.requestInformationReport)) {
      Hive.registerAdapter<RespondModel>(
        RespondModelAdapter(),
        override: true,
      );
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.requestInformation)) {
      Hive.registerAdapter<RequestInformationModel>(
        RequestInformationModelAdapter(),
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