import 'package:usdol/app/core.dart';

class HistoryResp {
  HistoryResp({
    this.total,
    this.lastPage,
    this.perPage,
    this.currentPage,
    this.items,
  });

  int? total;
  int? lastPage;
  int? perPage;
  int? currentPage;
  List<HistoryModel>? items;

  factory HistoryResp.fromJson(Map<String, dynamic> json) => HistoryResp(
        total: (json["total"] ?? 0) as int,
        lastPage: (json["lastPage"] ?? 0) as int,
        perPage: (json["perPage"] ?? 0) as int,
        currentPage: (json["currentPage"] ?? 0) as int,
        items: json["items"] != null && json["items"] is List<dynamic>
            ? List<HistoryModel>.from(
                (json["items"] as List<dynamic>).map<HistoryModel?>((dynamic x) {
                  if (x is Map<String, dynamic>) {
                    return HistoryModel.fromJson(x);
                  } else {
                    return null;
                  }
                }).toList(),
              )
            : null,
      );
}
