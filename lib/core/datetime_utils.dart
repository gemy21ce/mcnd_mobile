import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String format(DateFormat formatter) => formatter.format(this);
}
