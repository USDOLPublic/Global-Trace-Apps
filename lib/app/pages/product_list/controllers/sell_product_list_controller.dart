import 'package:usdol/app/core.dart';

class SellProductListController extends ProductListController {
  late final SellHttpService _httpService;

  @override
  void onInit() {
    super.onInit();
    _httpService = Get.find<SellHttpService>();
  }

  @override
  bool isHavePermissionManualAdd() {
    //PermissionActionDef.manuallyDefineNewProduct;
    return false;
  }

  @override
  bool isHavePermissionScanProduct() {
    return userInfo.hasPermission(PermissionActionDef.scanQrCodeInSale);
  }

  @override
  bool isHavePermissionInputProduct() {
    return userInfo.hasPermission(PermissionActionDef.inputProductIdInSale);
  }

  @override
  Future<BaseResp<ProductModel>> getProductById(String id) async {
    final isConnected = await NetworkUtil.isConnected();
    if (!isConnected) {
      return BaseResp.withError(
        errorMsg: S.current.noInternetConnection,
        statusCode: status408RequestTimeout,
      );
    }
    return await _httpService.getSellProduct(id);
  }

  @override
  bool isUsedProduct(ProductModel product) {
    return product.isSold == true;
  }

  @override
  String getReasonProductUsed() {
    return S.current.productAlreadySold;
  }
}
