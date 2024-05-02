import 'package:usdol/app/core.dart';

class ManagePartnerRepository extends ActiveRepo<String, FacilityRespModel> {
  @override
  String get boxName => ModelTypeDefine.facilityRespBox;

  Future<void> updateCacheData(List<FacilityRespModel> facilities) async {
    Map<String, FacilityRespModel> mapData = <String, FacilityRespModel>{};
    for (var e in facilities) {
      mapData[e.id ?? ""] = e;
    }
    if (mapData.isNotEmpty) {
      await assignAll(mapData);
    }
  }
}
