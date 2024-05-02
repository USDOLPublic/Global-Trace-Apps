import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class PercentageInputController extends FormFieldInputController {
  PercentageInputController({
    required super.definitionAttribute,
    required super.onChangedValue,
  });
  final TextEditingController inputTextController = TextEditingController();
  final FocusNode inputNode = FocusNode();

  double get inputValue {
    String strVal = inputTextController.text.trim().replaceAll(
          percentSymbols,
          '',
        );
    strVal = strVal.valueDoubleToCast;
    return double.tryParse(strVal) ?? 0;
  }

  @override
  AttributeRequest getValue() {
    return super.getValue()
      ..setValue(
        value: inputValue == 0 ? null : inputValue,
      );
  }

  @override
  bool isValid() {
    double percent = inputValue;
    return percent > 0 && percent <= 100 || isOptional();
  }

  String? inputValidation(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (RegExp(value.toString()).hasMatch(percentRegPattern)) {
      return S.current.fieldInvalid;
    } else {
      double percent = inputValue;
      if (percent > 100) {
        return S.current.percentMustNotBe;
      } else if (percent <= 0) {
        return S.current.percentMust;
      } else {
        return null;
      }
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
