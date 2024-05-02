import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class InputProductListController extends ProductListController {
  late final TransformHttpService _httpService;

  @override
  void onInit() {
    super.onInit();
    _httpService = Get.find<TransformHttpService>();
  }

  @override
  bool isHavePermissionManualAdd() {
    return false;
  }

  @override
  bool isHavePermissionScanProduct() {
    return userInfo.hasPermission(PermissionActionDef.assignQrCode);
  }

  @override
  bool isHavePermissionInputProduct() {
    return true;
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
    return await _httpService.getAssignProduct(id);
  }

  @override
  bool isUsedProduct(ProductModel product) {
    return product.isTransformed == true;
  }

  @override
  String getReasonProductUsed() {
    return S.current.productAlreadyTransformed;
  }

  @override
  String getPageTitle(BuildContext context) {
    return S.of(context).addInputProduct;
  }
}
