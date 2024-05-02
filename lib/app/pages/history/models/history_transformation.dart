import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_transformation.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.historyTransformation)
class HistoryTransformation extends HiveObject {
  HistoryTransformation({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.facilityId,
    this.uploadCertifications,
    this.transformationItems,
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
  List<FileAttachmentModel>? uploadCertifications;
  @HiveField(5)
  List<TransformationItem>? transformationItems;

  factory HistoryTransformation.fromJson(Map<String, dynamic> json) =>
      _$HistoryTransformationFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryTransformationToJson(this);

  factory HistoryTransformation.fromPendingRequest(TransformRequest request) {
    List<TransformationItem>? transformationItems;
    if (request.inputProducts != null && request.inputProducts!.isNotEmpty) {
      transformationItems ??= <TransformationItem>[];
      for (var element in request.inputProducts!) {
        transformationItems.add(TransformationItem.fromInputPending(element));
      }
    }
    //output
    List<ManualAddedProductRequest>? outputProducts =
        request.outputProduct?.outputProducts;
    if (outputProducts != null && outputProducts.isNotEmpty) {
      transformationItems ??= <TransformationItem>[];
      for (var element in outputProducts) {
        transformationItems.add(TransformationItem.fromOutputPending(
          element,
          element.dnaIdentifier,
        ));
      }
    }
    return HistoryTransformation(
      id: const Uuid().v1(),
      createdAt: request.createAt,
      transformationItems: transformationItems,
    );
  }

  TransformationItem? get transformationItem {
    if (transformationItems == null || transformationItems!.isEmpty) {
      return null;
    }
    return transformationItems!.first;
  }
}
