import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'attribute_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.attribute)
class AttributeModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final int? createdAt;
  @HiveField(2)
  final int? updatedAt;
  @HiveField(3)
  final String? name;
  @HiveField(4)
  final String? type;
  @HiveField(5)
  final String? category;
  @HiveField(6)
  final Map<String, String>? nameTranslation;
  @HiveField(7)
  final List<AttributeOptionModel>? options;

  AttributeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.type,
    this.category,
    this.nameTranslation,
    this.options,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeModelToJson(this);

  String getNameTranslateValue({String language = "en"}) {
    if (nameTranslation == null) {
      return '';
    }
    if (nameTranslation!.containsKey(language)) {
      return nameTranslation?[language] ?? '';
    }
    return (nameTranslation?['en'] ?? name ?? '').toString();
  }
}
