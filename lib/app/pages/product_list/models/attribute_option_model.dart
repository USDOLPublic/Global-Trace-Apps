import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'attribute_option_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.attributeOption)
class AttributeOptionModel extends HiveObject {
  @HiveField(0)
  final String? value;
  @HiveField(1)
  final Map<String, String>? translation;

  AttributeOptionModel({
    this.value,
    this.translation,
  });

  factory AttributeOptionModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeOptionModelToJson(this);

  String getTranslateValue({String language = "en"}) {
    if (translation == null) {
      return '';
    }
    if (translation!.containsKey(language)) {
      return translation?[language] ?? '';
    }
    return (translation?['en'] ?? '').toString();
  }
}
