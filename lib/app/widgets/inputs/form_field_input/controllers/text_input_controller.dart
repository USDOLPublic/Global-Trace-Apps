import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class TextInputController extends FormFieldInputController {
  TextInputController({
    required super.definitionAttribute,
    required super.onChangedValue,
    this.isMaskFormatter = false,
    this.isEnableQRCodeInput = false,
  });

  final TextEditingController inputTextController = TextEditingController();
  final FocusNode inputNode = FocusNode();
  bool isMaskFormatter;
  bool isEnableQRCodeInput;

  final MaskTextInputFormatter idMaskInput = MaskTextInputFormatter(
    mask: '###-###-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final String idRegPattern = (r'[a-zA-Z0-9]');

  String get inputValue {
    if (isMaskFormatter) {
      return inputTextController.text.trim().replaceAll("-", "");
    }
    return inputTextController.text.trim();
  }

  @override
  AttributeRequest getValue() {
    if (inputValue.isNotEmpty) {
      return super.getValue()..setValue(value: inputValue);
    } else {
      return super.getValue();
    }
  }

  @override
  bool isValid() {
    if (isMaskFormatter) {
      return inputValue.length == 9 || isOptional();
    }
    return inputValue.isNotEmpty || isOptional();
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
