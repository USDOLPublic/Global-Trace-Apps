import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'additional_attribute_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.additionalAttribute)
class AdditionalAttributeModel extends HiveObject {
  @HiveField(0)
  final dynamic value;
  @HiveField(1)
  final String? attributeId;
  @HiveField(2)
  final String? quantityUnit;
  @HiveField(3)
  final AttributeModel? attribute;

  AdditionalAttributeModel({
    this.value,
    this.attributeId,
    this.quantityUnit,
    this.attribute,
  });

  factory AdditionalAttributeModel.fromJson(Map<String, dynamic> json) =>
      _$AdditionalAttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalAttributeModelToJson(this);

  double? getTotalWeight() {
    if (attribute?.type != FieldType.productQuantity) {
      return 0;
    }
    double weightValue = double.tryParse(value.toString()) ?? 0;
    if(unitsOfLengthDef.contains(quantityUnit?.toLowerCase())){
      return null;
    }
    return WeightConverter.to(
      value: weightValue,
      targetUnit: defaultWeightUnit.value,
      sourceUnit: quantityUnit ?? 'kg',
    );
  }
}
