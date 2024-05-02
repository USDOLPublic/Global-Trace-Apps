import 'dart:convert';
import 'dart:core';
import 'package:usdol/app/core.dart';

class StaticResourceHelper {
  static final StaticResourceHelper _instance =
      StaticResourceHelper._internal();
  factory StaticResourceHelper() {
    return _instance;
  }
  StaticResourceHelper._internal();
  final InvitePartnerPermissionCacheService _invitePartnerPermissionCache =
      InvitePartnerPermissionCacheService();

  Future<void> init() async {
    await Future.wait([
      _invitePartnerPermissionCache.init(),
    ]);
  }

  Future<void> fetchStaticResource(bool isProductUser) async {
    LogUtil.d('[Start Cache Static Resource]');
    final ProfileHttpService profileHttpService = ProfileHttpService();
    final InvitePartnerService invitePartnerHttp = InvitePartnerService();
    final PurchaseHttpService purchaseHttpService = PurchaseHttpService();
    final TransformHttpService transformHttpService = TransformHttpService();
    List<Future<void>> fetchTasks = [
      cacheCommodityData(profileHttpService),
      cacheInvitePartnerPermission(invitePartnerHttp),
    ];
    if (isProductUser) {
      fetchTasks.addAll([
        cachePurchaseProductDefinition(purchaseHttpService),
        cachePurchaseSellerConfig(purchaseHttpService),
        cacheSoldProductDefinition(transformHttpService),
        cacheSeasonStartTime(profileHttpService),
      ]);
    }
    await Future.wait(fetchTasks);
    LogUtil.d('[Completed Cache Static Resource]');
  }

  Future<void> cacheCommodityData(ProfileHttpService httpService) async {
    final result = await httpService.getCommodities();
    if (result.isSuccess() && result.data != null) {
      await Prefs.saveStringList(Defines.commoditiesDataKey, result.data!);
    }
  }

  Future<void> cacheInvitePartnerPermission(
      InvitePartnerService httpService) async {
    final response = await httpService.getInvitePermission();
    if (response.isSuccess() && response.data != null) {
      Map<String, InvitePartnerPermission> mapData =
          <String, InvitePartnerPermission>{};
      for (var e in response.data!) {
        mapData[e.id ?? ''] = e;
      }
      if (mapData.isNotEmpty) {
        await _invitePartnerPermissionCache.repo.assignAll(mapData);
      }
    }
  }

  /// Notifies the user when any write operations occur.
  Stream<Map<String, InvitePartnerPermission>>
      get invitePartnerPermissionStream async* {
    yield* _invitePartnerPermissionCache.repo.dataStream;
  }

  //purchase config
  Future<void> cachePurchaseProductDefinition(
      PurchaseHttpService httpService) async {
    final result = await httpService.getPurchaseProductDefinition();
    if (result.isSuccess() && result.data != null) {
      String jsonString = jsonEncode(result.data?.toJson());
      await Prefs.saveString(Defines.purchaseProductDefinitionKey, jsonString);
    }
  }

  ProductDefinitionModel? getPurchaseProductDefinition() {
    String jsonString = Prefs.getString(Defines.purchaseProductDefinitionKey);
    try {
      Map<String, dynamic> jsonData =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return ProductDefinitionModel.fromJson(jsonData);
    } catch (e) {
      LogUtil.e("getPurchaseProductDefinition Error:" + e.toString());
      return null;
    }
  }

  //sold config
  Future<void> cacheSoldProductDefinition(
      TransformHttpService httpService) async {
    final result = await httpService.getSoldProductDefinition();
    if (result.isSuccess() && result.data != null) {
      String jsonString = jsonEncode(result.data?.toJson());
      await Prefs.saveString(Defines.soldProductDefinitionKey, jsonString);
    }
  }

  ProductDefinitionModel? getSoldProductDefinition() {
    String jsonString = Prefs.getString(Defines.soldProductDefinitionKey);
    try {
      Map<String, dynamic> jsonData =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return ProductDefinitionModel.fromJson(jsonData);
    } catch (e) {
      LogUtil.e("getSoldProductDefinition Error:" + e.toString());
      return null;
    }
  }

  Future<void> cachePurchaseSellerConfig(
      PurchaseHttpService httpService) async {
    final result = await httpService.getSellerConfig();
    if (result.isSuccess() && result.data != null) {
      String jsonString = jsonEncode(result.data?.toJson());
      await Prefs.saveString(Defines.purchaseSellerConfigKey, jsonString);
    }
  }

  Future<PurchaseSellerConfig?> getPurchaseSellerConfig() async {
    String jsonString = Prefs.getString(Defines.purchaseSellerConfigKey);
    try {
      Map<String, dynamic> jsonData =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return PurchaseSellerConfig.fromJson(jsonData);
    } catch (e) {
      LogUtil.e("getPurchaseSellerConfig Error:" + e.toString());
      return null;
    }
  }

  //Season start time
  Future<void> cacheSeasonStartTime(ProfileHttpService httpService) async {
    final result = await httpService.getSessionTime();
    if (result.isSuccess() && result.data != null) {
      String jsonString = jsonEncode(result.data?.toJson());
      await Prefs.saveString(Defines.seasonTimeKey, jsonString);
    }
  }

  SeasonTimeModel? getSeasonStartTime() {
    String jsonString = Prefs.getString(Defines.seasonTimeKey);
    try {
      Map<String, dynamic> jsonData =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return SeasonTimeModel.fromJson(jsonData);
    } catch (e) {
      LogUtil.e("getSeasonStartTime Error:" + e.toString());
      return null;
    }
  }
}
