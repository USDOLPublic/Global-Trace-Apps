import 'package:usdol/app/core.dart';

class SellScheduleSending extends ScheduleSending {
  SellScheduleSending({
    required super.fileHttpService,
    required this.sellHttpService,
  });
  final SellHttpService sellHttpService;

  @override
  Future<BaseResp<ProductModel>> getProductById(String id) async {
    return await sellHttpService.getSellProduct(id);
  }

  Future<BaseResp<dynamic>> sendRequestSell(SellRequest payload) async {
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
      payload.productIds.addAll(syncProductResult.productIds);
      payload.products.addAll(products);
    }

    ///
    ///Upload invoice files
    ///
    UploadResult invoiceUploadResult = await uploadCefFiles(
      payload.localInvoices,
    );
    if (invoiceUploadResult.isFailed) {
      return invoiceUploadResult.getErrorResponse();
    }
    payload.uploadInvoices = invoiceUploadResult.filesResp;

    ///
    ///Upload packing list files
    ///
    UploadResult packingUploadResult = await uploadCefFiles(
      payload.localPackingLists,
    );
    if (packingUploadResult.isFailed) {
      return packingUploadResult.getErrorResponse();
    }
    payload.uploadPackingLists = packingUploadResult.filesResp;

    ///
    ///Log Sell
    ///
    var res = await sellHttpService.addSell(payload);
    return res;
  }
}
