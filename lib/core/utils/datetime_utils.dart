import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String format(DateFormat formatter) => formatter.format(this);

  DateTime matchDateWith(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      hour,
      minute,
      second,
    );
  }

  bool isDateOnlyEquals(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isDateOnlyAfter(DateTime other) {
    return year > other.year ||
        (year == other.year && month > other.month) ||
        (year == other.year && month == other.month && day > other.day);
  }
}
