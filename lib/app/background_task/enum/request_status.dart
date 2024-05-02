enum RequestStatus {
  pending,
  failed,
  completed,
}

extension RequestStatusX on RequestStatus {
  String get valueAsString => toString().split('.').last;

  // Or as a function
  String asString() => toString().split('.').last;
}
