import 'package:usdol/app/core.dart';

class TransportProductListController extends ProductListController {
  late final TransportHttpService _httpService;

  @override
  void onInit() {
    super.onInit();
    _httpService = Get.find<TransportHttpService>();
  }

  @override
  bool isHavePermissionManualAdd() {
    return false;
  }

  @override
  bool isHavePermissionScanProduct() {
    return userInfo.hasPermission(PermissionActionDef.scanQrCodeInTransport);
  }

  @override
  bool isHavePermissionInputProduct() {
    return userInfo
        .hasPermission(PermissionActionDef.inputProductIdInTransport);
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
    return await _httpService.getTransportProduct(id);
  }

  @override
  bool isUsedProduct(ProductModel product) {
    return product.isTransported == true;
  }

  @override
  String getReasonProductUsed() {
    return S.current.productAlreadyTransported;
  }
}
