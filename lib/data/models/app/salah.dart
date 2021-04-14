import 'package:enum_to_string/enum_to_string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strings/strings.dart' as strings;

enum Salah {
  @JsonValue(0)
  fajr,
  @JsonValue(1)
  sunrise,
  @JsonValue(2)
  zuhr,
  @JsonValue(3)
  asr,
  @JsonValue(4)
  maghrib,
  @JsonValue(5)
  isha,
}

extension SalahExt on Salah {
  int getId() {
    switch (this) {
      case Salah.fajr:
        return 0;
      case Salah.sunrise:
        return 1;
      case Salah.zuhr:
        return 2;
      case Salah.asr:
        return 3;
      case Salah.maghrib:
        return 4;
      case Salah.isha:
        return 5;
    }
  }

  static Salah fromId(int id) {
    switch (id) {
      case 0:
        return Salah.fajr;
      case 1:
        return Salah.sunrise;
      case 2:
        return Salah.zuhr;
      case 3:
        return Salah.asr;
      case 4:
        return Salah.maghrib;
      case 5:
        return Salah.isha;
    }
    throw 'Unknown id $id';
  }

  String getStringName() {
    return strings.capitalize(EnumToString.convertToString(this).toLowerCase());
  }
}
