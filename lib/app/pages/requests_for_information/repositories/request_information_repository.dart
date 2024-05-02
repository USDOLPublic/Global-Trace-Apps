import 'package:usdol/app/core.dart';

class RequestInformationRepository
    extends ActiveRepo<String, RequestInformationModel> {
  @override
  String get boxName => ModelTypeDefine.requestInformationBox;

  @override
  Future<void> clear() async {
    var risk = Hive.box<Risk>(ModelTypeDefine.riskModelBox);
    await risk.clear();
    var facility = Hive.box<FacilityModel>(ModelTypeDefine.facilityModel);
    await facility.clear();
    var sourceRiskData =
        Hive.box<SourceRiskData>(ModelTypeDefine.sourceRiskDataBox);
    await sourceRiskData.clear();
    var subIdicatorRiskData =
        Hive.box<SubIndicatorRiskData>(ModelTypeDefine.subIndicatorRiskBox);
    await subIdicatorRiskData.clear();
    var indicatorRiskData =
        Hive.box<IndicatorRiskData>(ModelTypeDefine.indicatorRiskDataBox);
    await indicatorRiskData.clear();

    var riskData = Hive.box<RiskData>(ModelTypeDefine.riskDataBox);
    await riskData.clear();
    var dataRiskData =
        Hive.box<DataRiskDataModel>(ModelTypeDefine.dataRiskDataModelBox);
    await dataRiskData.clear();
    var assignee =
        Hive.box<AssigneeModel>(ModelTypeDefine.requestInformationAssignBox);
    await assignee.clear();
    var respond =
        Hive.box<RespondModel>(ModelTypeDefine.requestInformationReportBox);
    await respond.clear();
    return super.clear();
  }

  Future<void> putAndUpdate(List<RequestInformationModel> requests) async {
    Map<String, RequestInformationModel> mapData =
        <String, RequestInformationModel>{};
    for (var e in requests) {
      mapData[e.id ?? ""] = e;
    }
    if (mapData.isNotEmpty) {
      await putAllAndUpdateExistingMapped(
        mapData,
        (String key, RequestInformationModel? mutateMe,
            RequestInformationModel newValue) {
          return newValue;
        },
      );
    }
  }

  List<RequestInformationModel> getPageItem(RequestInformationReq infoReq) {
    List<RequestInformationModel> requests = getAllValues().values.toList();
    requests.sort((a, b) => b.getCreateDate().compareTo(a.getCreateDate()));
    int start = (infoReq.page - 1) * infoReq.perPage;
    int end = infoReq.page * infoReq.perPage;
    if (end > requests.length) {
      end = requests.length;
    }
    if (start > requests.length) {
      return <RequestInformationModel>[];
    }
    return requests.getRange(start, end).toList();
  }
}
