import 'package:path_provider/path_provider.dart';
import '../core.dart';

class HiveManager {
  static Future<void> init() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String hivePath = "$dir/${BuildConfig().env.dbName}-${BuildConfig().env.dbVersion}";
    Hive.init(hivePath);
  }

  static Future<void> close() async {
    await Hive.close();
  }

  static Future<void> clearBoxData<T>(String boxName) async {
    Box<T> box;
    if (!Hive.isBoxOpen(boxName)) {
      box = await Hive.openBox<T>(boxName);
    } else {
      box = Hive.box<T>(boxName);
    }
    await box.clear();
  }

  static Future<void> clearAllData() async {
    UserCacheService userCache = UserCacheService();
    await userCache.init();
    await userCache.userRepo.clear();

    PurchasePartnerCacheService purchasePartnerCache = PurchasePartnerCacheService();
    await purchasePartnerCache.init();
    await purchasePartnerCache.repo.clear();

    SellPartnerCacheService sellPartnerCache = SellPartnerCacheService();
    await sellPartnerCache.init();
    await sellPartnerCache.repo.clear();

    TransportPartnerCacheService transportPartnerCache = TransportPartnerCacheService();
    await transportPartnerCache.init();
    await transportPartnerCache.repo.clear();

    HistoryCacheService historyCache = HistoryCacheService();
    await historyCache.init();
    await historyCache.repo.clear();

    ManagePartnerCacheService managePartnerCacheService = ManagePartnerCacheService();
    await managePartnerCacheService.init();
    await managePartnerCacheService.repository.clear();

    RequestInformationCacheService requestInformationCache = RequestInformationCacheService();
    await requestInformationCache.init();
    await requestInformationCache.repo.clear();
  }
}
