import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class PurchaseProductListController extends ProductListController {
  late final PurchaseHttpService _httpService;

  @override
  void onInit() {
    super.onInit();
    _httpService = Get.find<PurchaseHttpService>();
  }

  @override
  void onReady() {
    super.onReady();
    _checkAndRedirectToAddManual();
  }

  @override
  bool isHavePermissionScanProduct() {
    return userInfo.hasPermission(PermissionActionDef.scanQrCodeInPurchase);
  }

  @override
  bool isHavePermissionInputProduct() {
    return userInfo.hasPermission(PermissionActionDef.inputProductIdInPurchase);
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
    return await _httpService.getPurchaseProduct(id);
  }

  @override
  String getPageTitle(BuildContext context) {
    return S.of(context).addProduct;
  }

  @override
  bool isUsedProduct(ProductModel product) {
    return product.isPurchased == true;
  }

  @override
  String getReasonProductUsed() {
    return S.current.productAlreadyPurchased;
  }

  void _checkAndRedirectToAddManual() {
    if (productList.isNotEmpty) {
      // do not redirect once have products
      return;
    }
    //
    bool isCanScanProduct = isHavePermissionScanProduct();
    bool isCanInputProduct = isHavePermissionInputProduct();
    bool isCanManualAdd = isHavePermissionManualAdd();
    if (!isCanScanProduct && !isCanInputProduct && isCanManualAdd) {
      _goToAddProductManually();
    }
  }

  void _goToAddProductManually() async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.addProductManually,
    );
    if (result != null && result is ManualAddedProductRequest) {
      addProductManual(result);
    } else {
      Get.back<dynamic>();
    }
  }
}
