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
}
