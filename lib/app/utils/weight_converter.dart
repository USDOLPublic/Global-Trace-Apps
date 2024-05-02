class WeightConverter {
  static double toKG({double value = 0, String unit = "KG"}) {
    double converted = value.toDouble();
    switch (unit.toLowerCase()) {
      case "lbs":
        converted = value * 0.45359237;
        break;
      case "unit":
      case "units":
        converted = value * 16000;
        break;
    }
    return converted;
  }

  static double toUnits({double value = 0, String unit = "KG"}) {
    double converted = value.toDouble();
    switch (unit.toLowerCase()) {
      case "lbs":
        converted = value / 35274;
        break;
      case "kg":
        converted = value / 16000.0;
        break;
    }
    return converted;
  }

  static double toLbs({double value = 0, String unit = "KG"}) {
    double converted = value.toDouble();
    switch (unit.toLowerCase()) {
      case "unit":
      case "units":
        converted = value * 35274;
        break;
      case "kg":
        converted = value * 2.20462262;
        break;
    }
    return converted;
  }

  static double to({double value = 0, String sourceUnit = "KG", String targetUnit = "KG"}) {
    double converted = value.toDouble();
    switch (targetUnit.toLowerCase()) {
      case "lbs":
        converted = toLbs(value: value, unit: sourceUnit);
        break;
      case "unit":
      case "units":
        converted = toUnits(value: value, unit: sourceUnit);
        break;
      case "kg":
        converted = toKG(value: value, unit: sourceUnit);
        break;
    }
    return converted;
  }

  static bool isDefaultValue(String value, String unit) {
    double converted = double.tryParse(value) ?? 0;
    switch (unit.toLowerCase()) {
      case "unit":
      case "units":
        return converted == 1;
      case "kg":
        return converted == 16000;
      case "lbs":
        return converted == 35274;
    }
    return false;
  }
}
