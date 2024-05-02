import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'indicator_model.g.dart';

@HiveType(typeId: ModelTypeDefine.indicator)
@JsonSerializable()
class IndicatorModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? parentId;
  @HiveField(4)
  String? name;
  @HiveField(5)
  int? type;
  @HiveField(6)
  int? riskSeverity;
  @HiveField(7)
  int? deletedAt;
  @HiveField(8)
  Map<String, dynamic>? translation;
  @HiveField(9)
  String? categoryId;
  IndicatorModel({
    required this.id,
    this.name,
    this.createdAt,
    this.deletedAt,
    this.type,
    this.updatedAt,
    this.parentId,
    this.categoryId,
    this.riskSeverity,
    this.translation,
  });
  factory IndicatorModel.fromJson(Map<String, dynamic> json) =>
      _$IndicatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$IndicatorModelToJson(this);

  String getNameTranslateValue({String language = "en"}) {
    if (translation == null) {
      return '';
    }
    if (translation!.containsKey(language)) {
      return (translation?[language] ?? '').toString();
    }
    return (translation?['en'] ?? name ?? '').toString();
  }
}
