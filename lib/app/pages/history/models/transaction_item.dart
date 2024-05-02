import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transaction_item.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.transactionItem)
class TransactionItem extends HiveObject {
  TransactionItem({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.transactionId,
    this.entityId,
    this.product,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? transactionId;
  @HiveField(4)
  String? entityId;
  @HiveField(5)
  ProductModel? product;

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemToJson(this);

  factory TransactionItem.fromProduct(ProductModel product) {
    return TransactionItem(
      id: const Uuid().v1(),
      product: product,
    );
  }

  factory TransactionItem.fromManualProduct(ManualAddedProductRequest manual) {
    List<FileAttachmentModel>? certifications;
    manual.getAttachmentFiles()?.forEach((element) {
      certifications ??= [];
      certifications!.add(
        FileAttachmentModel(
          fileName: FileUtil.getFileName(element),
          link: element,
        ),
      );
    });
    ProductModel product = ProductModel(
      certifications: certifications,
      isAddByManualForm: true,
      manualAdded: manual,
    );
    return TransactionItem(
      id: const Uuid().v1(),
      product: product,
    );
  }

  String? getWeightUnit() {
    if (product == null) return null;
    if (product!.isAddByManualForm) {
      return product?.manualAdded?.getQuantityUnit();
    } else {
      return product?.quantityUnit;
    }
  }

  double? getWeightValue() {
    if (product == null) return null;
    if (product!.isAddByManualForm) {
      return product?.manualAdded?.getQuantityValue();
    } else {
      return product?.quantity;
    }
  }

  String? getProductIdOrQrCode() {
    if (product == null) return null;
    if (product!.isAddByManualForm) {
      return product?.manualAdded?.getProductId();
    } else {
      return product?.code ?? product?.qrCode?.code;
    }
  }

  double? getVerified() {
    if (product == null) return null;
    if (product!.isAddByManualForm) {
      return null;
    } else {
      return product?.verifiedPercentage;
    }
  }

  String? getTrashContent() {
    return product?.getTrashContent();
  }

  double? getMoisture() {
    return product?.getMoisture();
  }
}
