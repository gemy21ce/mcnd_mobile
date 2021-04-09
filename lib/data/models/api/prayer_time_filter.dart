import 'package:enum_to_string/enum_to_string.dart';

enum PrayerTimeFilter {
  today,
  month,
  year,
}

extension PrayerTimeFilterExt on PrayerTimeFilter {
  String getApiStringValue() {
    return EnumToString.convertToString(this).toLowerCase();
  }
}
