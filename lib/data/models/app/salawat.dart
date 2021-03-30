import 'package:enum_to_string/enum_to_string.dart';
import 'package:strings/strings.dart' as strings;

enum Salah {
  FAJR,
  ZUHR,
  ASR,
  MAGHRIB,
  ISHA,
}

extension SalawatExt on Salah {
  String getStringName() {
    return strings.capitalize(EnumToString.convertToString(this).toLowerCase());
  }
}
