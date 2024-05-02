import 'package:usdol/app/core.dart';

class HistoryReq extends BaseReq {
  int page;
  int perPage;
  DateTime toTime;
  DateTime? fromTime;
  List<String>? types;

  HistoryReq({
    required this.page,
    required this.perPage,
    required this.toTime,
    this.fromTime,
    this.types,
  });

  int get from => (fromTime?.millisecondsSinceEpoch ?? 0) ~/ 1000;
  int get to => toTime.millisecondsSinceEpoch ~/ 1000;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> mapData = <String, dynamic>{
      "page": page,
      "perPage": perPage,
      "to": toTime.millisecondsSinceEpoch ~/ 1000,
    };

    if (fromTime != null) {
      mapData["from"] = fromTime!.millisecondsSinceEpoch ~/ 1000;
    }
    if (types != null && types!.isNotEmpty) {
      String typeStr = types!.join(";");
      mapData["types"] = typeStr;
    }
    return mapData;
  }
}
