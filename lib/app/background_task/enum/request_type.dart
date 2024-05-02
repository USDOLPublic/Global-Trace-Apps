enum RequestType{
  purchase,
  sell,
  assignProduct,
  assignLotId,
  transport,
  community,
  requestInformation,
  recordByProduct,
  none,
}


extension RequestTypeX on RequestType {
  String get valueAsString => toString().split('.').last;

  // Or as a function
  String asString() => toString().split('.').last;
}
