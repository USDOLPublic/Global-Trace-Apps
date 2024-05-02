import 'dart:io';
import 'package:intl/intl.dart';

extension DoubleConvert on double {
  // ignore: unused_element
  String get toStringNoZero {
    String strValue = toString();
    if (strValue.endsWith('.0') || strValue.endsWith(',0')) {
      return strValue.substring(0, strValue.length - 2);
    }
    return strValue;
  }

  String toNumericFormat({int? fractionDigits}) {
    //#,##0.###"
    final oCcy = NumberFormat.decimalPattern(Platform.localeName);
    if (fractionDigits != null) {
      oCcy.maximumFractionDigits = fractionDigits;
    }
    String numValue = toStringNoZero;
    if (oCcy.symbols.DECIMAL_SEP != '.') {
      numValue = numValue.replaceFirst(RegExp(oCcy.symbols.DECIMAL_SEP), '.');
    }
    double numberVal = double.tryParse(numValue) ?? 0;
    return oCcy.format(numberVal);
  }
}
