import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_definition_attribute_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.productDefinitionAttribute)
class ProductDefinitionAttributeModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final int? createdAt;
  @HiveField(2)
  final int? updatedAt;
  @HiveField(3)
  final String? productDefinitionId;
  @HiveField(4)
  final String? attributeId;
  @HiveField(5)
  final int? order;
  @HiveField(6)
  final bool? isAddManuallyOnly;
  @HiveField(7)
  final bool? isOptional;
  @HiveField(8)
  final AttributeModel? attribute;

  ProductDefinitionAttributeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.productDefinitionId,
    this.attributeId,
    this.order,
    this.isAddManuallyOnly,
    this.isOptional,
    this.attribute,
  });

  factory ProductDefinitionAttributeModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDefinitionAttributeModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProductDefinitionAttributeModelToJson(this);

  String? getAttributeType() {
    return attribute?.type;
  }
}
