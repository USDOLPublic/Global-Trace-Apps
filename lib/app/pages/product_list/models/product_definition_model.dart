import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_definition_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.productDefinition)
class ProductDefinitionModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final int? createdAt;
  @HiveField(2)
  final int? updatedAt;
  @HiveField(3)
  final String? name;
  @HiveField(4)
  final Map<String, String>? nameTranslation;
  @HiveField(5)
  final List<ProductDefinitionAttributeModel>? productDefinitionAttributes;
  ProductDefinitionModel({
    this.id,
    this.name,
    this.nameTranslation,
    this.productDefinitionAttributes,
    this.updatedAt,
    this.createdAt,
  });

  factory ProductDefinitionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDefinitionModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProductDefinitionModelToJson(this);
  
  String getTranslateValue({String language = "en"}) {
    if (nameTranslation == null) {
      return '';
    }
    if (nameTranslation!.containsKey(language)) {
      return nameTranslation?[language] ?? '';
    }
    return (nameTranslation?['en'] ?? '').toString();
  }
}
