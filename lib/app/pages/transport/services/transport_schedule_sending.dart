import 'package:usdol/app/core.dart';

class TransportScheduleSending extends ScheduleSending {
  TransportScheduleSending({
    required super.fileHttpService,
    required this.httpService,
  });
  final TransportHttpService httpService;

  @override
  Future<BaseResp<ProductModel>> getProductById(String id) async {
    return await httpService.getTransportProduct(id);
  }

  Future<BaseResp<dynamic>> sendRequestTransport(
      TransportRequest payload) async {
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
    if (syncProductResult.productIds.isNotEmpty) {
      payload.productIds.addAll(syncProductResult.productIds);
      payload.products.addAll(syncProductResult.products);
    }

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
    ///Log transport
    ///
    var res = await httpService.addTransport(payload);
    return res;
  }
}
