import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class NumberInputController extends FormFieldInputController {
  NumberInputController({
    required super.definitionAttribute,
    required super.onChangedValue,
  });
  final TextEditingController inputTextController = TextEditingController();
  final FocusNode inputNode = FocusNode();

  double get inputValue {
    String strVal = inputTextController.text.trim().valueDoubleToCast;
    return double.tryParse(strVal) ?? 0;
  }

  @override
  AttributeRequest getValue() {
    if (inputTextController.text.trim().isNotEmpty) {
      return super.getValue()..setValue(value: inputValue);
    } else {
      return super.getValue();
    }
  }

  @override
  bool isValid() {
    return inputValue > 0 || isOptional();
  }

  String? inputValidation(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!isValid()) {
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
  }
}
