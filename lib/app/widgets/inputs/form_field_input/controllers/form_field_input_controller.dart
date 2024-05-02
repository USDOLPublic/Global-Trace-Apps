import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

abstract class FormFieldInputController extends GetxController {
  FormFieldInputController({
    required this.definitionAttribute,
    required this.onChangedValue,
  });

  final ProductDefinitionAttributeModel definitionAttribute;
  final void Function()? onChangedValue;
  String languageCode = '';

  @override
  @mustCallSuper
  void onInit() {
    languageCode = Prefs.getString(
      Defines.languageKey,
      defaultValue: 'en',
    );
    super.onInit();
  }

  bool isValid();
  void checkValidation() {}

  @mustCallSuper
  AttributeRequest getValue() {
    return AttributeRequest(
      id: definitionAttribute.attributeId,
      type: definitionAttribute.attribute?.type,
      isOptional: definitionAttribute.isOptional,
      category: definitionAttribute.attribute?.category,
      name: definitionAttribute.attribute?.name,
    );
  }

  bool isOptional() {
    return definitionAttribute.isOptional == true;
  }

  String getTitle() {
    AttributeModel? attribute = definitionAttribute.attribute;
    String title = attribute?.getNameTranslateValue(language: languageCode) ?? '';
    if(isOptional()){
      title = "$title ${S.current.optional}";
    }
    return title;
  }

  bool isProductIdType() {
    return definitionAttribute.attribute?.type == FieldType.productId;
  }

  void reset();
}
