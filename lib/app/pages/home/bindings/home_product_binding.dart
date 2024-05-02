import 'package:usdol/app/core.dart';

class HomeProductBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<FileHttpService>()) {
      Get.put(FileHttpService());
    }
    final profileHttpService = Get.put(ProfileHttpService());
    final pendingReqCacheService = Get.put(PendingRequestCacheService());

    //Purchase
    final purchasePartnerCacheService = Get.put(PurchasePartnerCacheService());
    final purchaseHttpService = Get.put(PurchaseHttpService());
    //Sell
    final sellPartnerCacheService = Get.put(SellPartnerCacheService());
    final sellHttpService = Get.put(SellHttpService());
    //Transport
    final transportPartnerCacheService =
        Get.put(TransportPartnerCacheService());
    final transportHttpService = Get.put(TransportHttpService());
    //Transform
    final transformHttpService = Get.put(TransformHttpService());
    //Record by-product
    final recordProductHttp = Get.put(RecordProductHttpService());

    final hisCacheService = Get.put(HistoryCacheService());
    final hisHttpService = Get.put(HistoryHttpService());

    Get.put(ProductOfflineCacheManager(
      purchaseHttp: purchaseHttpService,
      purchasePartnerCache: purchasePartnerCacheService,
      sellHttp: sellHttpService,
      sellPartnerCache: sellPartnerCacheService,
      transportHttp: transportHttpService,
      transportPartnerCache: transportPartnerCacheService,
      profileHttpService: profileHttpService,
      historyHttp: hisHttpService,
      historyCache: hisCacheService,
    ));
    Get.put(ProductBackgroundHandler(
      purchaseSchedule: PurchaseScheduleSending(
        fileHttpService: Get.find<FileHttpService>(),
        purchaseHttpService: purchaseHttpService,
      ),
      sellSchedule: SellScheduleSending(
        fileHttpService: Get.find<FileHttpService>(),
        sellHttpService: sellHttpService,
      ),
      transportSchedule: TransportScheduleSending(
        fileHttpService: Get.find<FileHttpService>(),
        httpService: transportHttpService,
      ),
      transformSchedule: TransformScheduleSending(
        fileHttpService: Get.find<FileHttpService>(),
        transformHttpService: transformHttpService,
      ),
      recordProductHttp: recordProductHttp,
      pendingRequestCache: pendingReqCacheService,
    ));

    Get.put(OverviewHttpService());
    Get.put(OverviewController(isFullOverview: false), tag: 'home');
    Get.put(HomeProductController());
  }
}
