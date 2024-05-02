import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.history)
class HistoryModel extends HiveObject {
  HistoryModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.facilityId,
    this.type,
    this.recordedAt,
    this.deletedAt,
    this.recordProduct,
    this.transformation,
    this.transaction,
    this.status = HistoryStatus.complete,
    this.tradeType,
    this.note,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? facilityId;
  @HiveField(4)
  int? type;
  @HiveField(5)
  int? recordedAt;
  @HiveField(7)
  int? deletedAt;
  @HiveField(6)
  HistoryRecordProduct? recordProduct;
  @HiveField(8)
  HistoryTransformation? transformation;
  @HiveField(9)
  HistoryTransaction? transaction;
  @HiveField(10)
  String? status = HistoryStatus.complete;
  @HiveField(11)
  String? tradeType;
  @HiveField(12)
  String? note;

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);

  factory HistoryModel.empty() => HistoryModel(id: "");

  DateTime? getTradeDate() {
    return DateUtil.fromSeconds(recordedAt);
  }

  String getTradeName() {
    String trader = "";
    switch (type) {
      case TransactionType.purchase:
        if (transaction?.fromFacility != null) {
          trader = transaction?.fromFacility?.name ?? "";
        } else {
          trader = S.current.nonParticipating;
        }
        break;
      case TransactionType.sale:
        trader = transaction?.toFacility?.name ?? "";
        break;
      case TransactionType.transport:
        trader = transaction?.toFacility?.name ?? "";
        break;
    }
    return trader;
  }

  List<FileAttachmentModel> getCredentialFiles() {
    switch (type) {
      case TransactionType.purchase:
        return transaction?.uploadProofs ?? [];
      case TransactionType.sale:
        List<FileAttachmentModel>? files;
        if (transaction?.uploadInvoices != null) {
          files ??= [];
          files.addAll(transaction!.uploadInvoices!);
        }
        if (transaction?.uploadPackingLists != null) {
          files ??= [];
          files.addAll(transaction!.uploadPackingLists!);
        }
        return files ?? [];
      case TransactionType.transport:
        List<FileAttachmentModel>? files;
        if (transaction?.uploadProofs != null) {
          files ??= [];
          files.addAll(transaction!.uploadProofs!);
        }
        if (transaction?.uploadInvoices != null) {
          files ??= [];
          files.addAll(transaction!.uploadInvoices!);
        }
        if (transaction?.uploadPackingLists != null) {
          files ??= [];
          files.addAll(transaction!.uploadPackingLists!);
        }
        return files ??= [];
      case TransactionType.transformation:
        return transformation?.uploadCertifications ?? [];
      case TransactionType.recordByProduct:
        return recordProduct?.uploadProofs ?? [];
    }
    return [];
  }

  bool isTradeType() {
    return type == TransactionType.purchase || type == TransactionType.sale;
  }

  ///
  /// Parse form pending request
  ///
  factory HistoryModel.fromPendingRequest(
      dynamic req, String status, String note, DateTime createAt) {
    HistoryModel? history;
    int? transactionRecordedAt;
    if (req is PurchaseRequest) {
      history = HistoryModel.fromPurchaseRequest(req, status, createAt);
      transactionRecordedAt = history.transaction?.transactedAt;
    } else if (req is SellRequest) {
      history = HistoryModel.fromSellRequest(req, status, createAt);
      transactionRecordedAt = history.transaction?.transactedAt;
    } else if (req is TransportRequest) {
      history = HistoryModel.fromTransport(req, status, createAt);
      transactionRecordedAt = history.transaction?.transactedAt;
    } else if (req is TransformRequest) {
      history = HistoryModel.fromTransformRequest(req, status, createAt);
      transactionRecordedAt = history.transformation?.createdAt;
    } else if (req is RecordProductRequest) {
      history = HistoryModel.fromRecordProductRequest(req, status, createAt);
      transactionRecordedAt = history.recordProduct?.recordedAt;
    }
    // ignore: prefer_initializing_formals
    history?.note = note;
    history?.createdAt = createAt.millisecondsSinceEpoch ~/ 1000;
    history?.recordedAt = transactionRecordedAt;
    history ??= HistoryModel.empty();
    return history;
  }

  factory HistoryModel.fromPurchaseRequest(
    PurchaseRequest req,
    String status,
    DateTime createAt,
  ) {
    HistoryModel history = HistoryModel(
      status: status,
      type: TransactionType.purchase,
      transaction: HistoryTransaction.fromPurchaseRequest(req),
    );
    return history;
  }

  factory HistoryModel.fromSellRequest(
    SellRequest req,
    String status,
    DateTime createAt,
  ) {
    HistoryModel history = HistoryModel(
      status: status,
      type: TransactionType.sale,
      transaction: HistoryTransaction.fromSellRequest(req),
    );
    return history;
  }

  factory HistoryModel.fromTransport(
    TransportRequest req,
    String status,
    DateTime createAt,
  ) {
    HistoryModel history = HistoryModel(
      status: status,
      type: TransactionType.transport,
      transaction: HistoryTransaction.fromTransportRequest(req),
    );
    return history;
  }

  factory HistoryModel.fromTransformRequest(
    TransformRequest request,
    String status,
    DateTime createAt,
  ) {
    HistoryModel history = HistoryModel(
      status: status,
      type: TransactionType.transformation,
      transformation: HistoryTransformation.fromPendingRequest(request),
    );
    return history;
  }

  factory HistoryModel.fromRecordProductRequest(
    RecordProductRequest request,
    String status,
    DateTime createAt,
  ) {
    HistoryModel history = HistoryModel(
      status: status,
      type: TransactionType.recordByProduct,
      recordProduct: HistoryRecordProduct.fromPendingRequest(request),
    );
    return history;
  }
}
