import 'package:usdol/app/core.dart';

class HomeLaborBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<FileHttpService>()) {
      Get.put(FileHttpService());
    }
    Get.put<ProfileHttpService>(ProfileHttpService());
    final pendingReqCacheService =
        Get.put<PendingRequestCacheService>(PendingRequestCacheService());

    var facilitiesHttp =
        Get.put<FacilitiesHttpService>(FacilitiesHttpService());
    var indicatorCache =
        Get.put<IndicatorCacheService>(IndicatorCacheService());
    var riskScanHttp = Get.put<RiskScanHttpService>(RiskScanHttpService());
    var requestInformationCacheService =
        Get.put<RequestInformationCacheService>(
            RequestInformationCacheService());
    var requestInformationHttpService =
        Get.put<RequestInformationHttpService>(RequestInformationHttpService());
    var managePartnerCache =
        Get.put<ManagePartnerCacheService>(ManagePartnerCacheService());

    Get.put<LaborOfflineCacheManager>(LaborOfflineCacheManager(
      facilitiesHttp: facilitiesHttp,
      indicatorCache: indicatorCache,
      requestInformationCacheService: requestInformationCacheService,
      requestInformationHttpService: requestInformationHttpService,
      riskScanHttp: riskScanHttp,
      managePartnerCache: managePartnerCache,
    ));
    Get.put<LaborBackgroundHandler>(LaborBackgroundHandler(
      riskScanSchedule: RiskScanScheduleSending(
        fileHttpService: Get.find<FileHttpService>(),
        riskScanHttpService: riskScanHttp,
      ),
      pendingRequestCache: pendingReqCacheService,
      requestInfoSchedule: RequestInformationScheduleSending(
        fileHttpService: Get.find<FileHttpService>(),
        requestInfoHttpService: requestInformationHttpService,
      ),
    ));
    Get.put<HomeLaborController>(HomeLaborController());
  }
}
