class DateRangeModel {
  DateTime? start;
  DateTime? end;

  DateRangeModel({this.start, this.end});

  bool isEmpty() {
    return start == null || end == null;
  }

  bool isNotEmpty() {
    return start != null && end != null;
  }

  List<DateTime?> toList() {
    return [start, end];
  }

  factory DateRangeModel.fromList(List<DateTime?> dates) {
    DateRangeModel dateRange = DateRangeModel();
    if (dates.isNotEmpty) {
      dateRange.start = dates.first;
      if (dates.length > 1) {
        dateRange.end = dates.last;
      }
    }
    return dateRange;
  }
}
