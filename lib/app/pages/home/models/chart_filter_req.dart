import 'package:usdol/app/core.dart';

class ChartFilterReq extends BaseReq {
  DateTime? from;
  DateTime? to;

  ChartFilterReq({required this.from, required this.to});

  factory ChartFilterReq.none() => ChartFilterReq(
        from: DateTime.now(),
        to: DateTime.now(),
      );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> filter = <String, dynamic>{};
    if (from != null) {
      filter['from'] = from!.millisecondsSinceEpoch ~/ 1000;
    }

    if (to != null) {
      filter['to'] = to!.millisecondsSinceEpoch ~/ 1000;
    } else {
      filter['to'] = DateTime.now().microsecondsSinceEpoch ~/ 1000;
    }
    return filter;
  }
}
