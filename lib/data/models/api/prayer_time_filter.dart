import 'package:enum_to_string/enum_to_string.dart';
import 'package:json_annotation/json_annotation.dart';

enum PrayerTimeFilter {
  TODAY,
  MONTH,
  YEAR,
}

extension PrayerTimeFilterExt on PrayerTimeFilter {
  String getApiStringValue() {
    return EnumToString.convertToString(this).toLowerCase();
  }
}
