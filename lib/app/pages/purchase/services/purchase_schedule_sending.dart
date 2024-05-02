import 'package:usdol/app/core.dart';

class PurchaseScheduleSending extends ScheduleSending {
  PurchaseScheduleSending({
    required super.fileHttpService,
    required this.purchaseHttpService,
  });
  final PurchaseHttpService purchaseHttpService;

  @override
  Future<BaseResp<ProductModel>> getProductById(String id) async {
    return await purchaseHttpService.getPurchaseProduct(id);
  }

  Future<BaseResp<dynamic>> sendRequestPurchase(PurchaseRequest payload) async {
    final isConnected = await NetworkUtil.isConnected();
    if (!isConnected) {
      return BaseResp<dynamic>.withError(
        errorMsg: S.current.noInternetConnection,
        statusCode: status408RequestTimeout,
      );
    }

    ///
    ///Sync Pending Products
    ///
    SyncProductResult syncProductResult = await syncProductsPending(
      payload.products,
    );
    if (syncProductResult.errorResult != null) {
      return syncProductResult.errorResult!;
    }
    List<ProductModel> products = <ProductModel>[];
    if (syncProductResult.productIds.isNotEmpty) {
      payload.productIds ??= [];
      payload.productIds!.addAll(syncProductResult.productIds);
      payload.products ??= [];
      payload.products!.addAll(products);
    }

    ///
    ///Upload cer files
    ///
    UploadResult uploadResult = await uploadCefFiles(payload.localProofs);
    if (uploadResult.isFailed) {
      return uploadResult.getErrorResponse();
    }
    payload.uploadProofs = uploadResult.filesResp;
    List<UploadResult>? manualUploadResult =
        await payload.manualAddedData?.uploadFileAttachments(
      uploadFile: uploadCefFiles,
    );

    ///
    ///Upload cer files in manual products
    ///
    UploadResult? uploadFailed = manualUploadResult?.firstWhereOrNull(
      (element) => element.isFailed,
    );
    if (manualUploadResult != null && uploadFailed != null) {
      return uploadFailed.getErrorResponse();
    }

    ///
    ///Add purchase
    ///
    var res = await purchaseHttpService.addPurchase(payload);
    return res;
  }
}
