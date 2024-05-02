import 'dart:io';
import 'package:intl/intl.dart';

import '../validation/regex_pattern.dart';

extension StringConvert on String {
  String toNumericFormat({int? fractionDigits}) {
    if (isEmpty) return "";
    //#,##0.###"
    final oCcy = NumberFormat.decimalPattern(Platform.localeName);
    if (fractionDigits != null) {
      oCcy.maximumFractionDigits = fractionDigits;
    }
    String numValue = this;
    if (oCcy.symbols.DECIMAL_SEP != '.') {
      numValue = numValue.replaceFirst(RegExp(oCcy.symbols.DECIMAL_SEP), '.');
    }
    double numberVal = double.tryParse(numValue) ?? 0;
    return oCcy.format(numberVal);
  }

  String get valueIntToCast {
    if (isEmpty) return "";
    String numValue = this;
    numValue = numValue.replaceAll(RegExp('[^0-9]'), '');
    return numValue;
  }

  String get valueDoubleToCast {
    if (isEmpty) return "";
    final oCcy = NumberFormat.decimalPattern(Platform.localeName);
    String numValue = this;
    if (numValue.contains(oCcy.symbols.GROUP_SEP)) {
      numValue = numValue.replaceAll(oCcy.symbols.GROUP_SEP, '');
    }
    if (oCcy.symbols.DECIMAL_SEP != '.') {
      numValue = numValue.replaceFirst(RegExp(oCcy.symbols.DECIMAL_SEP), '.');
    }
    return numValue;
  }

  String get toNumericText => replaceAll(RegexPattern.notNumericText, '');
}
