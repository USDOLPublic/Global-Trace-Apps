class CheckOarIdRequestModel {
  String? oarId;
  int? page;
  int? pageSize;

  CheckOarIdRequestModel({
    this.oarId,
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['oarId'] = oarId;
    map['page'] = page;
    map['pageSize'] = pageSize;
    return map;
  }
}
