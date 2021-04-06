import 'package:enum_to_string/enum_to_string.dart';
import 'package:strings/strings.dart' as strings;

enum Salah {
  fajr,
  zuhr,
  asr,
  maghrib,
  isha,
}

extension SalahExt on Salah {
  String getStringName() {
    return strings.capitalize(EnumToString.convertToString(this).toLowerCase());
  }
}
