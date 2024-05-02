import 'dart:async';

import 'package:usdol/app/core.dart';

class FilterController extends GetxController {
  FilterController({FilterModel? filter}) {
    if (filter != null && filter.isHaveFillter()) {
      //gradeSelected = filter.grade;
      purchaserSelected = filter.purchaser;
      sellerSelected = filter.seller;
    }
  }

  late final PurchasePartnerCacheService _purchasePartnerCache;
  late final PurchaseHttpService _purchaseHttp;

  late final SellPartnerCacheService _sellPartnerCache;
  late final SellHttpService _sellHttp;

  //
  final _purchaserList = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get purchaserList => _purchaserList.value;
  set purchaserList(List<InputItem> value) => _purchaserList.value = value;

  final _sellerList = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get sellerList => _sellerList.value;
  set sellerList(List<InputItem> value) => _sellerList.value = value;

  final _purchaserSelected = InputItem.empty().obs;
  InputItem get purchaserSelected => _purchaserSelected.value;
  set purchaserSelected(InputItem value) => _purchaserSelected.value = value;

  final _sellerSelected = InputItem.empty().obs;
  InputItem get sellerSelected => _sellerSelected.value;
  set sellerSelected(InputItem value) => _sellerSelected.value = value;

  StreamSubscription? _subPurchasePartner;
  StreamSubscription? _subSellPartner;

  @override
  void onInit() {
    _purchasePartnerCache = PurchasePartnerCacheService();
    _sellPartnerCache = SellPartnerCacheService();
    _purchaseHttp = PurchaseHttpService();
    _sellHttp = SellHttpService();

    super.onInit();
  }

  @override
  void onReady() {
    _initData();
    super.onReady();
  }

  Future<void> _initData() async {
    _loadPurchasers();
    _loadSellers();
  }

  @override
  void onClose() async {
    await _subPurchasePartner?.cancel();
    await _subSellPartner?.cancel();
    super.onClose();
  }

  Future<void> _loadPurchasers() async {
    await _purchasePartnerCache.init();
    _subPurchasePartner = _purchasePartnerCache.repo.dataStream.listen((Map<String, PurchasePartner> event) {
      if (event.isNotEmpty) {
        List<PurchasePartner> partners = event.values.toList();
        _purchaserList.clear();
        for (PurchasePartner partner in partners) {
          _purchaserList.add(InputItem(displayLabel: partner.name ?? "", value: partner.id));
        }
        _purchaserList.refresh();
      }
    });

    //cache partner
    await _loadPurchasePartner();
  }

  Future<void> _loadSellers() async {
    await _sellPartnerCache.init();
    _subSellPartner = _sellPartnerCache.repo.dataStream.listen((Map<String, SellPartner> event) {
      if (event.isNotEmpty) {
        List<SellPartner> partners = event.values.toList();
        _sellerList.clear();
        for (SellPartner partner in partners) {
          _sellerList.add(InputItem(displayLabel: partner.name ?? "", value: partner.id));
        }
        _sellerList.refresh();
      }
    });

    //cache partner
    await _loadSellPartner();
  }

  Future<void> _loadPurchasePartner() async {
    var resp = await _purchaseHttp.getPurchasePartners();
    if (resp.isSuccess() && resp.data != null) {
      Map<String, PurchasePartner> mapData = <String, PurchasePartner>{};
      for (var e in resp.data!) {
        mapData[e.id] = e;
      }
      if (mapData.isNotEmpty) {
        _purchasePartnerCache.repo.assignAll(mapData);
      }
    }
  }

  Future<void> _loadSellPartner() async {
    var resp = await _sellHttp.getSellPartners();
    if (resp.isSuccess() && resp.data != null) {
      Map<String, SellPartner> mapData = <String, SellPartner>{};
      for (var e in resp.data!) {
        mapData[e.id] = e;
      }
      if (mapData.isNotEmpty) {
        _sellPartnerCache.repo.assignAll(mapData);
      }
    }
  }

  void onChangePurchaser(InputItem? item) {
    if (item != null && purchaserSelected.value != item.value) {
      purchaserSelected = item;
    } else {
      purchaserSelected = InputItem.empty();
    }
  }

  void onChangeSeller(InputItem? item) {
    if (item != null && sellerSelected.value != item.value) {
      sellerSelected = item;
    } else {
      sellerSelected = InputItem.empty();
    }
  }
}
