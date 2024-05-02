import 'package:usdol/app/core.dart';

class ScheduleSending {
  ScheduleSending({
    required this.fileHttpService,
  });
  final FileHttpService fileHttpService;

  Future<UploadResult> uploadCefFiles(List<String>? filePaths) async {
    if (filePaths == null || filePaths.isEmpty) {
      return UploadResult.withEmpty();
    }
    final result = await fileHttpService.uploadFiles(filePaths);
    if (result.isHaveRespData()) {
      return UploadResult.withData(result);
    }
    String errorMessage = result.getErrorMessage(
      defaultErrMessage: S.current.unableToUploadTheFile,
    );
    LogUtil.e("Upload Files: " + errorMessage);
    return UploadResult.withError(errorMessage, result);
  }

  Future<BaseResp<ProductModel>> getProductById(String id) async {
    return BaseResp.withError(errorMsg: '');
  }

  Future<SyncProductResult> syncProductsPending(
    List<ProductModel>? products,
  ) async {
    List<ProductModel> pendingProducts = products
            ?.where(
              (element) => element.productCodeManual != null,
            )
            .toList() ??
        [];
    List<ProductModel> productsSynced = <ProductModel>[];
    BaseResp<dynamic>? errorResult;
    await Future.forEach(pendingProducts, (productCode) async {
      final productResult =
          await getProductById(productCode.productCodeManual!);
      if (!productResult.isSuccess() || productResult.data == null) {
        errorResult = productResult;
      } else {
        ProductModel product = productResult.data!;
        productsSynced.add(product);
      }
    });
    return SyncProductResult(
      products: productsSynced,
      productIds: _getProductIdsPending(productsSynced),
      errorResult: errorResult,
    );
  }

  List<String> _getProductIdsPending(List<ProductModel>? products) {
    if (products == null) return [];
    List<String> productIds = <String>[];
    for (var element in products) {
      if (element.id != null) {
        productIds.add(element.id!);
      }
    }
    return productIds;
  }
}

class SyncProductResult {
  List<ProductModel> products;
  List<String> productIds;
  BaseResp<dynamic>? errorResult;

  SyncProductResult({
    this.errorResult,
    required this.productIds,
    required this.products,
  });
}
