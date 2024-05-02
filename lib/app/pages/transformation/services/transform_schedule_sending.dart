import 'package:usdol/app/core.dart';

class TransformScheduleSending extends ScheduleSending {
  TransformScheduleSending({
    required super.fileHttpService,
    required this.transformHttpService,
  });
  final TransformHttpService transformHttpService;

  @override
  Future<BaseResp<ProductModel>> getProductById(String id) async {
    return await transformHttpService.getAssignProduct(id);
  }

  Future<BaseResp<dynamic>> sendRequestTransform(TransformRequest payload) async {
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
      payload.inputProducts,
    );
    if (syncProductResult.errorResult != null) {
      return syncProductResult.errorResult!;
    }
    List<ProductModel> products = <ProductModel>[];
    if (syncProductResult.productIds.isNotEmpty) {
      payload.inputProductIds ??= [];
      payload.inputProductIds!.addAll(syncProductResult.productIds);
      payload.inputProducts ??= [];
      payload.inputProducts!.addAll(products);
    }

    //
    ///Upload cer files
    ///
    ///
    List<UploadResult>? manualUploadResult =
        await payload.outputProduct?.uploadFileAttachments(
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
    ///Add transform
    ///
    var res = await transformHttpService.addTransform(payload);
    return res;
  }
}
