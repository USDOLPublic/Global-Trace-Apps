import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.product)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final int? createdAt;
  @HiveField(2)
  final int? updatedAt;
  @HiveField(3)
  final String? productDefinitionId;
  @HiveField(4)
  final String? code;
  @HiveField(5)
  final String? dnaIdentifier;
  @HiveField(6)
  final double? verifiedPercentage;
  @HiveField(7)
  final double? notVerifiedPercentage;
  @HiveField(8)
  final bool? isPurchased;
  @HiveField(9)
  final bool? isSold;
  @HiveField(10)
  final bool? isTransformed;
  @HiveField(11)
  final bool? isTransported;
  @HiveField(12)
  final bool? isManualAdded;
  @HiveField(13)
  final List<AdditionalAttributeModel>? additionalAttributes;
  @HiveField(14)
  final String? createdFacilityId;
  @HiveField(15)
  final List<FileAttachmentModel>? certifications;
  @HiveField(16)
  final double? quantity;
  @HiveField(17)
  final String? quantityUnit;
  @HiveField(18)
  final bool? isHavingCertification;
  @HiveField(19)
  final ProductDefinitionModel? productDefinition;
  @HiveField(20)
  final QrCodeModel? qrCode;
  @HiveField(21)
  final ManualAddedProductRequest? manualAdded;
  @HiveField(22)
  final bool isAddByManualForm;
  @HiveField(23)
  final String? productCodeManual;

  ProductModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.productDefinitionId,
    this.code,
    this.dnaIdentifier,
    this.verifiedPercentage,
    this.notVerifiedPercentage,
    this.isPurchased,
    this.isSold,
    this.isTransformed,
    this.isTransported,
    this.isManualAdded,
    this.additionalAttributes,
    this.createdFacilityId,
    this.certifications,
    this.quantity,
    this.quantityUnit,
    this.isHavingCertification,
    this.productDefinition,
    this.qrCode,
    this.manualAdded,
    this.isAddByManualForm = false,
    this.productCodeManual,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  String getProductIdDisplay() {
    if (productCodeManual != null) {
      return productCodeManual!;
    }
    if (isAddByManualForm) {
      AttributeRequest? attribute = manualAdded?.attributes?.firstWhereOrNull(
        (e) => e.type == FieldType.productId,
      );
      return (attribute?.value ?? '').toString();
    } else {
      return code ?? qrCode?.code ?? '';
    }
  }

  List<FileAttachmentModel>? getCertifications() {
    if (isAddByManualForm) {
      List<String> filePaths = manualAdded?.getAttachmentFiles() ?? [];
      return filePaths
          .map((e) => FileAttachmentModel(
                link: e,
                fileName: FileUtil.getFileName(e),
              ))
          .toList();
    } else {
      return certifications;
    }
  }

  double? getTotalWeight() {
    double totalWeight = 0;
    bool isNotWeightUnit = false;
    if (isAddByManualForm) {
      manualAdded?.attributes?.forEach((element) {
        double? weightValue = element.getTotalWeight();
        if (weightValue == null) {
          isNotWeightUnit = true;
        } else {
          totalWeight += weightValue;
        }
      });
    } else if (additionalAttributes != null) {
      additionalAttributes?.forEach((element) {
        double? weightValue = element.getTotalWeight();
        if (weightValue == null) {
          isNotWeightUnit = true;
        } else {
          totalWeight += weightValue;
        }
      });
    } else {
      isNotWeightUnit = true;
    }
    return isNotWeightUnit ? null : totalWeight;
  }

  double? getMoisture() {
    dynamic moistureLevel;
    if (isAddByManualForm) {
      manualAdded?.attributes?.forEach((element) {
        if (element.name?.toLowerCase() ==
            FieldName.moistureLevel.toLowerCase()) {
          moistureLevel = element.value;
        }
      });
    } else {
      additionalAttributes?.forEach((element) {
        if (element.attribute?.name?.toLowerCase() ==
            FieldName.moistureLevel.toLowerCase()) {
          moistureLevel = element.value;
        }
      });
    }
    return double.tryParse(moistureLevel.toString());
  }

  String? getTrashContent() {
    String? trashContent;
    if (isAddByManualForm) {
      manualAdded?.attributes?.forEach((element) {
        if (element.name?.toLowerCase() ==
            FieldName.trashContent.toLowerCase()) {
          trashContent = element.value?.toString();
        }
      });
    } else {
      additionalAttributes?.forEach((element) {
        if (element.attribute?.name?.toLowerCase() ==
            FieldName.trashContent.toLowerCase()) {
          trashContent = element.value?.toString();
        }
      });
    }
    return trashContent;
  }
}
