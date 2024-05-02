import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_transaction.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.historyTransaction)
class HistoryTransaction extends HiveObject {
  HistoryTransaction({
    this.totalWeight,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.fromFacilityId,
    this.toFacilityId,
    this.price,
    this.currency,
    this.weightUnit,
    this.purchaseOrderNumber,
    this.invoiceNumber,
    this.packingListNumber,
    this.transactedAt,
    this.uploadProofs,
    this.uploadInvoices,
    this.uploadPackingLists,
    this.creatorId,
    this.deletedAt,
    this.toFacility,
    this.fromFacility,
    this.transactionItems,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  double? totalWeight;
  @HiveField(2)
  int? createdAt;
  @HiveField(3)
  int? updatedAt;
  @HiveField(4)
  String? fromFacilityId;
  @HiveField(5)
  String? toFacilityId;
  @HiveField(6)
  double? price;
  @HiveField(7)
  String? currency;
  @HiveField(8)
  String? weightUnit;
  @HiveField(9)
  String? purchaseOrderNumber;
  @HiveField(10)
  String? invoiceNumber;
  @HiveField(11)
  String? packingListNumber;
  @HiveField(12)
  int? transactedAt;
  @HiveField(13)
  List<FileAttachmentModel>? uploadProofs;
  @HiveField(14)
  List<FileAttachmentModel>? uploadInvoices;
  @HiveField(15)
  List<FileAttachmentModel>? uploadPackingLists;
  @HiveField(16)
  String? creatorId;
  @HiveField(17)
  int? deletedAt;
  @HiveField(18)
  FacilityModel? toFacility;
  @HiveField(19)
  FacilityModel? fromFacility;
  @HiveField(20)
  List<TransactionItem>? transactionItems;

  factory HistoryTransaction.fromJson(Map<String, dynamic> json) =>
      _$HistoryTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryTransactionToJson(this);

  factory HistoryTransaction.fromPurchaseRequest(PurchaseRequest request) {
    List<TransactionItem>? transactionItems;
    request.products?.forEach(
      (element) {
        transactionItems ??= [];
        transactionItems!.add(TransactionItem.fromProduct(element));
      },
    );
    request.manualAddedData?.manualAddedProducts?.forEach(
      (element) {
        transactionItems ??= [];
        transactionItems!.add(TransactionItem.fromManualProduct(element));
      },
    );
    return HistoryTransaction(
      id: const Uuid().v1(),
      currency: request.currency,
      price: double.tryParse(request.price ?? ''),
      transactedAt: request.transactedAt,
      purchaseOrderNumber: request.purchaseOrderNumber,
      uploadProofs: request.localProofs?.map((e) {
        return FileAttachmentModel(
          fileName: FileUtil.getFileName(e),
          link: e,
        );
      }).toList(),
      fromFacilityId: request.fromFacilityId,
      fromFacility: FacilityModel(
        name: request.fromFacilityName,
      ),
      transactionItems: transactionItems,
    );
  }

  factory HistoryTransaction.fromSellRequest(SellRequest request) {
    List<TransactionItem>? transactionItems;
    for (var element in request.products) {
      transactionItems ??= [];
      transactionItems.add(TransactionItem.fromProduct(element));
    }
    return HistoryTransaction(
      id: const Uuid().v1(),
      currency: request.currency,
      price: double.tryParse(request.price),
      invoiceNumber: request.invoiceNumber,
      transactedAt: request.transactedAt,
      packingListNumber: request.packingListNumber,
      uploadInvoices: request.localInvoices?.map((e) {
        return FileAttachmentModel(
          fileName: FileUtil.getFileName(e),
          link: e,
        );
      }).toList(),
      uploadPackingLists: request.localPackingLists?.map((e) {
        return FileAttachmentModel(
          fileName: FileUtil.getFileName(e),
          link: e,
        );
      }).toList(),
      toFacilityId: request.toFacilityId,
      toFacility: FacilityModel(
        name: request.toFacilityName,
      ),
      transactionItems: transactionItems,
    );
  }

  factory HistoryTransaction.fromTransportRequest(TransportRequest request) {
    List<TransactionItem>? transactionItems;
    for (var element in request.products) {
      transactionItems ??= [];
      transactionItems.add(TransactionItem.fromProduct(element));
    }
    return HistoryTransaction(
      id: const Uuid().v1(),
      totalWeight: request.totalWeight,
      weightUnit: request.weightUnit,
      transactedAt: request.transactedAt,
      packingListNumber: request.packingListNumber,
      uploadPackingLists: request.localPackingLists?.map((e) {
        return FileAttachmentModel(
          fileName: FileUtil.getFileName(e),
          link: e,
        );
      }).toList(),
      toFacilityId: request.toFacilityId,
      toFacility: FacilityModel(
        name: request.toFacilityName,
      ),
      transactionItems: transactionItems,
    );
  }

  String getTotalWeightInfo() {
    double? totalWeight;
    transactionItems?.forEach((element) {
      String? weightUnit = element.getWeightUnit();
      double? weightValue = element.getWeightValue();
      if (!unitsOfLengthDef.contains(weightUnit) &&
          weightValue != null &&
          weightUnit != null) {
        double weightConverted = WeightConverter.to(
          value: weightValue,
          sourceUnit: weightUnit,
          targetUnit: defaultWeightUnit.value,
        );
        if (totalWeight == null) {
          totalWeight = weightConverted;
        } else {
          totalWeight = totalWeight! + weightConverted;
        }
      }
    });
    if (totalWeight != null) {
      String totalWeightString = totalWeight!.toNumericFormat();
      return "$totalWeightString ${defaultWeightUnit.displayLabel}";
    } else {
      return '-';
    }
  }

  String getPriceInfo() {
    if (price != null && currency != null) {
      String priceString = price!.toNumericFormat();
      return "$priceString $currency";
    }
    return '-';
  }
}
