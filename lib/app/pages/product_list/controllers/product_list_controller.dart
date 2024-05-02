import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class ProductListController extends GetxController {
  final RxList<ProductModel> _productList = RxList.empty();
  // ignore: invalid_use_of_protected_member
  List<ProductModel> get productList => _productList.value;
  set productList(List<ProductModel> value) => _productList.value = value;

  final _enableDoneButton = false.obs;
  bool get enableDoneButton => _enableDoneButton.value;
  set enableDoneButton(bool value) => _enableDoneButton.value = value;

  final _enableAddButton = false.obs;
  bool get enableAddButton => _enableAddButton.value;
  set enableAddButton(bool value) => _enableAddButton.value = value;

  final TextEditingController productIdController = TextEditingController();
  String get productIdInput => productIdController.text.trim();

  late final UserModel userInfo;
  late final FileHttpService _fileHttpService;

  @override
  @mustCallSuper
  void onInit() {
    userInfo = MainController.to.userInfo;
    _fileHttpService = Get.find<FileHttpService>();
    if (Get.arguments != null && Get.arguments is List<ProductModel>) {
      productList = Get.arguments as List<ProductModel>;
      _checkValidProducts();
    }
    super.onInit();
  }

  @override
  @mustCallSuper
  void onReady() {
    productIdController.addListener(() {
      if (productIdInput.isNotEmpty) {
        enableAddButton = true;
      } else {
        enableAddButton = false;
      }
    });
    super.onReady();
  }

  bool isHavePermissionScanProduct() {
    return true;
  }

  bool isHavePermissionInputProduct() {
    return true;
  }

  bool isHavePermissionManualAdd() {
    return true;
  }

  Widget inputProductFormDetails() {
    return const SizedBox.shrink();
  }

  bool isUsedProduct(ProductModel product) {
    return false;
  }

  String getReasonProductUsed() {
    return '';
  }

  String getPageTitle(BuildContext context) {
    return S.of(context).productList;
  }

  void _checkValidProducts() {
    if (productList.isNotEmpty) {
      enableDoneButton = true;
    } else {
      enableDoneButton = false;
    }
  }

  bool _isSameIdByScan(String? id, ProductModel item) {
    String? qrCode = item.qrCode?.code;
    String? productId = item.code;
    if (qrCode != null && qrCode == id) {
      return true;
    }
    if (productId != null && productId == id) {
      return true;
    }
    return false;
  }

  bool _isSameIdByManualForm(String? id, ProductModel item, bool isQrCode) {
    if (isQrCode) {
      String? qrCode = item.manualAdded?.qrCode;
      return qrCode != null && qrCode == id;
    } else {
      String? productId = item.manualAdded?.getProductId();
      return productId != null && productId == id;
    }
  }

  bool _isProductExisted(String? id, {bool isQrCode = false}) {
    List<ProductModel> products = productList.where((ProductModel element) {
      if (element.isAddByManualForm) {
        return _isSameIdByManualForm(id, element, isQrCode);
      } else {
        return _isSameIdByScan(id, element);
      }
    }).toList();
    return products.isNotEmpty;
  }

  void removeProduct(String? id) {
    productList.removeWhere((element) => element.id == id);
    _productList.refresh();
    _checkValidProducts();
  }

  void addProduct(ProductModel product) {
    productList.add(product);
    _productList.refresh();
    _checkValidProducts();
  }

  Future<BaseResp<ProductModel>> getProductById(String id) async {
    return BaseResp.withError(errorMsg: '');
  }

  Future<bool> addProductById(String id) async {
    if (_isProductExisted(id)) {
      SnackBars.warning(message: S.current.duplicateProduct).show();
      return false;
    }
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final result = await getProductById(id);
    processingDialog.hide();
    if (result.isHaveRespData()) {
      ProductModel product = result.data!;
      if (isUsedProduct(product)) {
        SnackBars.error(message: getReasonProductUsed()).show();
        return false;
      } else {
        addProduct(product);
        return true;
      }
    }
    if (OfflineHttpStatus.pendingStatus.contains(result.statusCode)) {
      addProduct(
        ProductModel(
          id: const Uuid().v1(),
          productCodeManual: id,
        ),
      );
      return true;
    }
    SnackBars.error(
      message: result.getErrorMessage(
        defaultErrMessage: S.current.genericErrorDescriptionShort,
      ),
    ).show();
    return false;
  }

  bool addProductManual(ManualAddedProductRequest manualAdded) {
    if (_isProductExisted(
      manualAdded.getProductId(),
      isQrCode: manualAdded.qrCode != null,
    )) {
      SnackBars.warning(message: S.current.duplicateProduct).show();
      return false;
    }
    addProduct(
      ProductModel(
        id: const Uuid().v1(),
        isAddByManualForm: true,
        manualAdded: manualAdded,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
    return true;
  }

  Future<List<int>?> downloadProductCerFile(String path,
      {Function(int, int)? onReceiveProgress}) async {
    var res = await _fileHttpService.downloadFile(
      path,
      onReceiveProgress: onReceiveProgress,
    );
    if (res.isSuccess() && res.data != null) {
      return res.data;
    } else {
      String errorMessage = res.getErrorMessage();
      SnackBars.error(message: errorMessage).show(duration: 5000);
      return null;
    }
  }
}
