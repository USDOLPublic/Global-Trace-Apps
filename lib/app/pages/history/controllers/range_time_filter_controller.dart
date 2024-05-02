import 'package:usdol/app/core.dart';

class RangeTimeFilterController extends GetxController {
  RangeTimeFilterController({DateRangeModel? range}) {
    if (range != null && range.isNotEmpty()) {
      rangeSelected = range;
    }
  }

  final _isEnableApply = false.obs;
  bool get isEnableApply => _isEnableApply.value;
  set isEnableApply(bool value) => _isEnableApply.value = value;

  final Rxn<DateRangeModel> _rangeSelected = Rxn<DateRangeModel>();
  DateRangeModel? get rangeSelected => _rangeSelected.value;
  set rangeSelected(DateRangeModel? value) {
    _rangeSelected.value = value;
    if (rangeSelected != null && rangeSelected!.isNotEmpty()) {
      isEnableApply = true;
    } else {
      isEnableApply = false;
    }
  }

  void updateRange(List<DateTime?> dates) {
    DateRangeModel range = DateRangeModel.fromList(dates);
    if (range.start != null && range.end != null) {
      DateTime endDate = range.end!;
      DateTime now = DateTime.now();
      endDate = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
      );
      range.end = endDate;
      rangeSelected = range;
    } else {
      rangeSelected = null;
    }
  }
}
