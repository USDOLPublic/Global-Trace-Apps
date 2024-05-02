import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class NumberUnitInputController extends FormFieldInputController {
  NumberUnitInputController({
    required super.definitionAttribute,
    required super.onChangedValue,
  });

  final TextEditingController inputTextController = TextEditingController();
  final FocusNode inputNode = FocusNode();
  final _itemSelected = InputItem.empty().obs;
  InputItem get itemSelected => _itemSelected.value;
  set itemSelected(InputItem value) {
    _itemSelected.value = value;
    onChangedValue?.call();
  }

  List<InputItem> options = <InputItem>[];

  double get inputValue {
    String strVal = inputTextController.text.trim().valueDoubleToCast;
    return double.tryParse(strVal) ?? 0;
  }

  @override
  void onInit() {
    super.onInit();
    List<AttributeOptionModel> attributeOption =
        definitionAttribute.attribute?.options ?? [];
    for (var element in attributeOption) {
      options.add(
        InputItem(
          value: element.value ?? '',
          displayLabel: element.getTranslateValue(language: languageCode),
        ),
      );
    }
  }

  @override
  AttributeRequest getValue() {
    if (isOptional() && (inputValue <= 0 || itemSelected.isEmpty())) {
      return super.getValue()
        ..setValue(
          value: null,
          quantityUnit: null,
        );
    }
    return super.getValue()
      ..setValue(
        value: inputValue,
        quantityUnit: itemSelected.value,
      );
  }

  @override
  bool isValid() {
    return (inputValue > 0 && itemSelected.isNotEmpty()) || isOptional();
  }

  String? inputValidation(String? value) {
    if (value != null && value.isNotEmpty && inputValue <= 0) {
      return S.current.fieldInvalid;
    } else {
      return null;
    }
  }

  void inputOnChanged(String val) {
    onChangedValue?.call();
  }

  @override
  void reset() {
    inputTextController.clear();
    itemSelected = InputItem.empty();
  }
}
