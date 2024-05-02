class NumConverter{
  static double toDouble(dynamic value){
    if(value == null) {
      return 0;
    }
    if(value is double){
      return value;
    }
    if(value is int){
      return value.toDouble();
    }
    if(value is String){
      return double.tryParse(value)??0.0;
    }
    return 0.0;
  }
}