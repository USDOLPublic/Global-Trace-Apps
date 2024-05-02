import 'package:usdol/app/core.dart';

class LaborOfflineCacheManager {
  final IndicatorCacheService indicatorCache;
  final FacilitiesHttpService facilitiesHttp;
  final RequestInformationHttpService requestInformationHttpService;
  final RequestInformationCacheService requestInformationCacheService;
  final RiskScanHttpService riskScanHttp;
  final ManagePartnerCacheService managePartnerCache;

  LaborOfflineCacheManager({
    required this.facilitiesHttp,
    required this.indicatorCache,
    required this.requestInformationCacheService,
    required this.requestInformationHttpService,
    required this.riskScanHttp,
    required this.managePartnerCache,
  });

  ///
  ///Cache all data used for offline mode
  ///Call when launch app => enter home screen
  ///
  Future<void> cacheData() async {
    await cacheIndicators();
    await cacheRequestInformation();
    await cacheFacilities();
  }

  ///
  ///Cache Indicators list
  ///
  Future<void> cacheIndicators() async {
    await indicatorCache.init();

    final resp = await facilitiesHttp.getIndicators();
    if (resp.isSuccess() && resp.data != null) {
      Map<String, IndicatorModel> mapData = <String, IndicatorModel>{};
      for (var e in resp.data!) {
        if (e.id != null) {
          mapData[e.id!] = e;
        }
      }
      if (mapData.isNotEmpty) {
        indicatorCache.repo.assignAll(mapData);
      }
    }
  }

  ///
  ///Cache Request Information list
  ///
  Future<void> cacheRequestInformation() async {
    await requestInformationCacheService.init();
    var res = await requestInformationHttpService
        .getRequestInformation(RequestInformationReq(
      page: 1,
      perPage: 20,
    ));
    if (res.isSuccess()) {
      List<RequestInformationModel> requestInfoData =
          <RequestInformationModel>[];
      if (res.data != null && res.data!.items != null) {
        requestInfoData = res.data!.items!;
      }
      await requestInformationCacheService.repo.putAndUpdate(requestInfoData);
    }
  }

  ///
  ///Cache Facility list
  ///
  Future<void> cacheFacilities() async {
    await managePartnerCache.init();
    var res = await riskScanHttp.searchFacility("");

    if (res.isSuccess()) {
      List<FacilityRespModel> facilities = <FacilityRespModel>[];
      if (res.data != null) {
        facilities = res.data!;
      }
      await managePartnerCache.repository.updateCacheData(facilities);
    }
  }
}
