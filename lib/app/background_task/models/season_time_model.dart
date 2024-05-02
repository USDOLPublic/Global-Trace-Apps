import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'season_time_model.g.dart';

@JsonSerializable()
class SeasonTimeModel {
  int? seasonStartTime;
  int? seasonDuration;

  SeasonTimeModel({
    this.seasonDuration,
    this.seasonStartTime,
  });

  factory SeasonTimeModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonTimeModelToJson(this);

  List<DateRangeModel> getListCircleDays(bool isMassBalance) {
    List<DateRangeModel> circleList = <DateRangeModel>[];
    DateTime startDate = DateTime.now();
    if (seasonStartTime != null) {
      startDate = DateTime.fromMillisecondsSinceEpoch(seasonStartTime! * 1000);
    }
    if (isMassBalance) {
      circleList.add(DateRangeModel(start: startDate, end: DateTime.now()));
    } else {
      int noOfCycleMonth = seasonDuration ?? 1;
      DateTime lastDayOfMonth = DateUtil.getLastDayOfMonth(DateTime.now());
      DateTime startCircle = DateTime(startDate.year, startDate.month, 1);
      while (startCircle.millisecondsSinceEpoch <=
          lastDayOfMonth.millisecondsSinceEpoch) {
        DateTime start = DateTime.parse(startCircle.toIso8601String());
        DateTime endCircle = DateTime(
            startCircle.year, startCircle.month + noOfCycleMonth - 1, 1);

        DateTime end = DateUtil.getLastDayOfMonth(endCircle);
        // Set to last day of current month
        // if (DateUtil.getLastDayOfMonth(DateTime.now()).isBefore(end)) {
        //   end = DateUtil.getLastDayOfMonth(DateTime.now());
        // }
        circleList.add(DateRangeModel(start: start, end: end));
        //update
        startCircle =
            DateTime(startCircle.year, startCircle.month + noOfCycleMonth, 1);
      }
    }
    return circleList.reversed.toList();
  }
}
