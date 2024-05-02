import 'package:usdol/app/core.dart';

class HistoryCacheService extends CacheServiceInterface {
  final repo = HistoryRepo();
  @override
  Future<void> initRepos() async {
    await openBox<QrCodeModel>(ModelTypeDefine.qrCodeBox);
    await openBox<FileAttachmentModel>(ModelTypeDefine.fileAttachmentUploadBox);
    await openBox<AttributeOptionModel>(ModelTypeDefine.attributeOptionBox);
    await openBox<AttributeModel>(ModelTypeDefine.attributeBox);
    await openBox<AdditionalAttributeModel>(
        ModelTypeDefine.additionalAttributeBox);
    await openBox<ProductDefinitionAttributeModel>(
        ModelTypeDefine.productDefinitionAttributeBox);
    await openBox<ProductDefinitionModel>(ModelTypeDefine.productDefinitionBox);
    await openBox<AttributeRequest>(ModelTypeDefine.attributeRequestBox);
    await openBox<ManualAddedProductRequest>(
        ModelTypeDefine.manualAddedRequestBox);
    await openBox<ProductModel>(ModelTypeDefine.productBox);
    await openBox<FacilityModel>(ModelTypeDefine.facilityModel);
    await openBox<TransactionItem>(ModelTypeDefine.transactionItemBox);
    await openBox<HistoryTransaction>(ModelTypeDefine.historyTransactionBox);
    await openBox<TransformationItem>(ModelTypeDefine.transformationItemBox);
    await openBox<HistoryTransformation>(
        ModelTypeDefine.historyTransformationBox);
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    registerTypeAdapter(
      ModelTypeDefine.qrCode,
      QrCodeModelAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.fileAttachmentUpload,
      FileAttachmentModelAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.attributeOption,
      AttributeOptionModelAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.attribute,
      AttributeModelAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.additionalAttribute,
      AdditionalAttributeModelAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.productDefinitionAttribute,
      ProductDefinitionAttributeModelAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.productDefinition,
      ProductDefinitionModelAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.attributeRequest,
      AttributeRequestAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.manualAddedRequest,
      ManualAddedProductRequestAdapter(),
    );

    registerTypeAdapter(
      ModelTypeDefine.product,
      ProductModelAdapter(),
    );

    registerTypeAdapter(
      ModelTypeDefine.facility,
      FacilityModelAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.transactionItem,
      TransactionItemAdapter(),
    );

    registerTypeAdapter(
      ModelTypeDefine.historyTransaction,
      HistoryTransactionAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.transformationItem,
      TransformationItemAdapter(),
    );
    registerTypeAdapter(
      ModelTypeDefine.historyTransformation,
      HistoryTransformationAdapter(),
    );

    registerTypeAdapter(
      ModelTypeDefine.historyRecordByProduct,
      HistoryRecordProductAdapter(),
    );

    registerTypeAdapter(
      ModelTypeDefine.history,
      HistoryModelAdapter(),
    );
  }

  @override
  Future<void> dispose() async {
    await repo.dispose();
    return super.dispose();
  }
}
