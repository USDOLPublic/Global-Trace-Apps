extension DateTimeExtension on DateTime {
  DateTime get endOfDay => DateTime(
        year,
        month,
        day,
        23,
        59,
        59,
        999,
      );
}
