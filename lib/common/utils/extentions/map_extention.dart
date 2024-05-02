extension MapParsing on Map<dynamic, dynamic> {
  // ignore: unused_element
  double? getDouble(dynamic key) {
    if (this[key] == null) {
      return null;
    }
    if (this[key] is int) {
      return (this[key] as int).toDouble();
    }
    if (this[key] is double) {
      return (this[key] as double);
    }
    if (this[key] is String) {
      return double.tryParse((this[key] as String));
    }
    return null;
  }
}
