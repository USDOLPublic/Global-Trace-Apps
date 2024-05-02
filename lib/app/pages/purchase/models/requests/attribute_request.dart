import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'attribute_request.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.attributeRequest)
class AttributeRequest extends HiveObject {
  @HiveField(0)
  final String? category;
  @HiveField(1)
  final bool? isOptional;
  @HiveField(2)
  final String? type;
  @HiveField(3)
  final String? id;
  @HiveField(4)
  dynamic value;
  @HiveField(5)
  String? quantityUnit;
  @HiveField(6)
  final String? name;

  AttributeRequest({
    this.category,
    this.isOptional,
    this.type,
    this.id,
    this.value,
    this.quantityUnit,
    this.name,
  });

  factory AttributeRequest.fromJson(Map<String, dynamic> json) =>
      _$AttributeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeRequestToJson(this);

  void setValue({
    dynamic value,
    String? quantityUnit,
  }) {
    this.value = value;
    this.quantityUnit = quantityUnit;
  }

  double? getTotalWeight() {
    if (type != FieldType.productQuantity) {
      return 0;
    }
    double weightValue = double.tryParse(value.toString()) ?? 0;

    if (unitsOfLengthDef.contains(quantityUnit?.toLowerCase())) {
      return null;
    }
    return WeightConverter.to(
      value: weightValue,
      targetUnit: defaultWeightUnit.value,
      sourceUnit: quantityUnit ?? 'kg',
    );
  }

  Future<UploadResult> uploadFileAttachments({
    required Future<UploadResult> Function(List<String>) uploadFile,
  }) async {
    if (category != FieldCategory.attachments) {
      return UploadResult.withEmpty();
    }
    if (value == null || value is! List) {
      return UploadResult.withEmpty();
    }
    List<String> paths = <String>[];
    for (var element in (value as List)) {
      paths.add(element.toString());
    }
    if (paths.isEmpty) {
      return UploadResult.withEmpty();
    }
    if (value is! List<UploadFileResp>) {
      UploadResult result = await uploadFile(paths);
      if (result.isSuccess) {
        value = result.filesResp;
      }
      return result;
    }
    return UploadResult.withEmpty();
  }
}
