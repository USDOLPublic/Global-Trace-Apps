import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transformation_item.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.transformationItem)
class TransformationItem extends HiveObject {
  TransformationItem({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.transformationId,
    this.entityId,
    this.isInput,
    this.product,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? transformationId;
  @HiveField(4)
  String? entityId;
  @HiveField(5)
  bool? isInput;
  @HiveField(6)
  ProductModel? product;

  factory TransformationItem.fromJson(Map<String, dynamic> json) =>
      _$TransformationItemFromJson(json);

  Map<String, dynamic> toJson() => _$TransformationItemToJson(this);

  factory TransformationItem.fromInputPending(ProductModel inputProduct) {
    return TransformationItem(
      id: const Uuid().v1(),
      product: inputProduct,
    );
  }

  factory TransformationItem.fromOutputPending(
    ManualAddedProductRequest manual,
    String? dnaIdentifier,
  ) {
    ProductModel product = ProductModel(
      isAddByManualForm: true,
      manualAdded: manual,
      dnaIdentifier: dnaIdentifier,
    );
    return TransformationItem(
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

  String? getDNA() {
    if (product == null) return null;
    return product?.dnaIdentifier;
  }
}
