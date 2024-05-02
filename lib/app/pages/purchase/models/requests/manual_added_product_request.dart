import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'manual_added_product_request.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.manualAddedRequest)
class ManualAddedProductRequest extends HiveObject {
  @HiveField(0)
  final String? code;
  @HiveField(1)
  final List<AttributeRequest>? attributes;
  @HiveField(2)
  final bool? isManualAdded;
  @HiveField(3)
  final String? qrCode;
  @HiveField(4)
  final String? dnaIdentifier;

  ManualAddedProductRequest({
    this.code,
    this.attributes,
    this.isManualAdded,
    this.dnaIdentifier,
    this.qrCode,
  });

  factory ManualAddedProductRequest.fromJson(Map<String, dynamic> json) =>
      _$ManualAddedProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManualAddedProductRequestToJson(this);

  List<String>? getAttachmentFiles() {
    if (attributes == null) {
      return null;
    }
    List<AttributeRequest> attachmentAttributes = attributes!
        .where(
          (e) => e.category == FieldCategory.attachments,
        )
        .toList();
    List<String> attachments = <String>[];
    for (var element in attachmentAttributes) {
      if (element.value != null && element.value is List<String>) {
        attachments.addAll(element.value as List<String>);
      }
    }
    return attachments;
  }

  Future<List<UploadResult>> uploadFileAttachments({
    required Future<UploadResult> Function(List<String>) uploadFile,
  }) async {
    List<Future<UploadResult>> uploadTasks = <Future<UploadResult>>[];
    attributes?.forEach((element) {
      uploadTasks.add(element.uploadFileAttachments(uploadFile: uploadFile));
    });
    List<UploadResult> uploadResult = await Future.wait(uploadTasks);
    uploadResult.removeWhere((element) => element.isNone);
    return uploadResult;
  }

  String? getQuantityUnit() {
    String? quantityUnit;
    attributes?.forEach((element) {
      if (element.type == FieldType.productQuantity) {
        quantityUnit = element.quantityUnit;
      }
    });
    return quantityUnit;
  }

  double? getQuantityValue() {
    dynamic quantityValue;
    attributes?.forEach((element) {
      if (element.type == FieldType.productQuantity) {
        quantityValue = element.value;
      }
    });
    return double.tryParse(quantityValue.toString());
  }

  String? getProductId() {
    String? productId;
    attributes?.forEach((element) {
      if (element.type == FieldType.productId) {
        productId = element.value?.toString();
      }
    });
    return productId;
  }
}
