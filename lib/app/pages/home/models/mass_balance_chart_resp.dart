import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'mass_balance_chart_resp.g.dart';

@JsonSerializable()
class MassBalanceChartResp {
  bool? canCalculate;
  double? verifiedQuantity;
  double? notVerifiedQuantity;
  int? lastUpdatedAt;
  String? quantityUnit;

  MassBalanceChartResp({
    this.canCalculate,
    this.lastUpdatedAt,
    this.notVerifiedQuantity,
    this.quantityUnit,
    this.verifiedQuantity,
  });

  factory MassBalanceChartResp.fromJson(Map<String, dynamic> json) =>
      _$MassBalanceChartRespFromJson(json);

  Map<String, dynamic> toJson() => _$MassBalanceChartRespToJson(this);

  int getLastTimeUpdateAt() {
    return lastUpdatedAt ?? DateTime.now().microsecondsSinceEpoch ~/ 1000;
  }

  DateTime getLastTimeUpdate() {
    if (lastUpdatedAt != null && lastUpdatedAt! > 0) {
      return DateUtil.fromSeconds(lastUpdatedAt) ?? DateTime.now();
    }
    return DateTime.now();
  }

  bool get isCanCalculate => canCalculate == true;
}
