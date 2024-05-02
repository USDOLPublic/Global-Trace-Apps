import 'package:usdol/app/core.dart';

class ProductOfflineCacheManager {
  final PurchasePartnerCacheService purchasePartnerCache;
  final PurchaseHttpService purchaseHttp;

  final SellPartnerCacheService sellPartnerCache;
  final SellHttpService sellHttp;

  final TransportPartnerCacheService transportPartnerCache;
  final TransportHttpService transportHttp;

  final ProfileHttpService profileHttpService;

  final HistoryHttpService historyHttp;
  final HistoryCacheService historyCache;

  ProductOfflineCacheManager({
    required this.purchaseHttp,
    required this.purchasePartnerCache,
    required this.sellHttp,
    required this.sellPartnerCache,
    required this.transportHttp,
    required this.transportPartnerCache,
    required this.profileHttpService,
    required this.historyHttp,
    required this.historyCache,
  });

  ///
  ///Cache all data used for offline mode
  ///Call when launch app => enter home screen
  ///
  Future<void> cacheData() async {
    await cachePartners();
    // await cacheQRCode();
    // await cacheLots();
    await cacheHistories();
  }

  ///
  ///Cache all partners use for offline mode
  ///
  Future<void> cachePartners() async {
    await Future.wait([
      _cacheSellPartners(),
      _cachePurchasePartners(),
      _cacheTransportPartners(),
    ]);
  }

  Future<void> _cacheSellPartners() async {
    await sellPartnerCache.init();
    var resp = await sellHttp.getSellPartners();
    if (resp.isSuccess()) {
      Map<String, SellPartner> mapData = <String, SellPartner>{};
      if (resp.data != null) {
        for (var e in resp.data!) {
          mapData[e.id] = e;
        }
      }
      await sellPartnerCache.repo.assignAll(mapData);
    }
  }

  Future<void> _cachePurchasePartners() async {
    await purchasePartnerCache.init();
    var resp = await purchaseHttp.getPurchasePartners();
    if (resp.isSuccess()) {
      Map<String, PurchasePartner> mapData = <String, PurchasePartner>{};
      if (resp.data != null) {
        for (var e in resp.data!) {
          mapData[e.id] = e;
        }
      }
      await purchasePartnerCache.repo.assignAll(mapData);
    }
  }

  Future<void> _cacheTransportPartners() async {
    await transportPartnerCache.init();
    var resp = await transportHttp.getTransportPartners();
    if (resp.isSuccess()) {
      Map<String, TransportPartner> mapData = <String, TransportPartner>{};
      if (resp.data != null) {
        for (var e in resp.data!) {
          mapData[e.id] = e;
        }
      }
      await transportPartnerCache.repo.assignAll(mapData);
    }
  }

  ///
  ///Cache all QRCodes use for assign lot id in offline mode
  ///
  Future<void> cacheQRCode() async {
    // await qrCodeCache.init();
    // final resp = await assignQRHttp.getQrCodes();
    // if (resp.isSuccess()) {
    //   Map<String, QRCodeModel> mapData = <String, QRCodeModel>{};
    //   if (resp.data != null) {
    //     for (var e in resp.data!) {
    //       mapData[e] = QRCodeModel(qrCode: e);
    //     }
    //   }
    //   await qrCodeCache.repo.assignAll(mapData);
    // }
  }

  ///
  ///Get histories from server.
  ///
  Future<void> cacheHistories() async {
    await historyCache.init();
    var res = await historyHttp
        .getHistories(HistoryReq(page: 1, perPage: 99, toTime: DateTime.now()));
    if (res.isSuccess() && res.data != null && res.data!.items != null) {
      List<HistoryModel> hisData = res.data!.items!;
      await historyCache.repo.putAndUpdate(hisData);
    }
  }
}
