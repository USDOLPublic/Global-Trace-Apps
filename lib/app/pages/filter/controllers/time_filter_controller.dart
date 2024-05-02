import 'package:usdol/app/core.dart';

class TimeFilterController extends GetxController {
  final _isEnableApply = false.obs;
  bool get isEnableApply => _isEnableApply.value;
  set isEnableApply(bool value) => _isEnableApply.value = value;

  List<InputItem> cycleDateTimeList = <InputItem>[];
  List<DateRangeModel> _listDateRange = <DateRangeModel>[];

  final _cycleSelected = InputItem.empty().obs;
  InputItem get cycleSelected => _cycleSelected.value;
  set cycleSelected(InputItem value) => _cycleSelected.value = value;

  TimeFilterController({DateRangeModel? range}) {
    if (range != null) {
      String startRange = range.start?.toIso8601String() ?? "";
      cycleSelected = InputItem(
        value: startRange,
        displayLabel: "",
      );
      isEnableApply = true;
    }
  }

  @override
  void onInit() {
    UserModel user = MainController.to.userInfo;
    SeasonTimeModel? seasonTime = StaticResourceHelper().getSeasonStartTime();
    if (seasonTime != null) {
      _listDateRange = seasonTime.getListCircleDays(
        user.isMassBalance(),
      );
      for (var circle in _listDateRange) {
        String startDateStr = DateUtil.parseFromDateTime(
          circle.start,
          "d MMM, yyyy",
        );
        String endDateStr = DateUtil.parseFromDateTime(
          circle.end,
          "d MMM, yyyy",
        );
        String startRangeIso = circle.start?.toIso8601String() ?? "";
        LogUtil.d("Date: $startDateStr ~ $endDateStr");
        cycleDateTimeList.add(
          InputItem(
            value: startRangeIso,
            displayLabel: "$startDateStr ~ $endDateStr",
          ),
        );
      }
    }
    super.onInit();
  }

  void onChangeCycleSelected(InputItem? item) {
    if (item != null && cycleSelected.value != item.value) {
      cycleSelected = item;
    } else {
      cycleSelected = InputItem.empty();
    }
  }

  DateRangeModel? getRangeDate() {
    if (cycleSelected.isEmpty()) {
      return DateRangeModel();
    } else {
      DateRangeModel? rangeSelected = _listDateRange.firstWhereOrNull(
        (element) => element.start?.toIso8601String() == cycleSelected.value,
      );
      return rangeSelected ?? DateRangeModel();
    }
  }
}
