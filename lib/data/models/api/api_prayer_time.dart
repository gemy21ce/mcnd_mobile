import 'package:json_annotation/json_annotation.dart';
import 'package:mcnd_mobile/data/models/mcnd_datetime_converter.dart';

part 'api_prayer_time.g.dart';

@JsonSerializable()
@McndTimeConverter()
class ApiPrayerTime {
  @JsonKey(name: "d_date")
  @McndDateConverter()
  final DateTime date;

  @JsonKey(name: "fajr_begins")
  final DateTime fajrAzan;
  @JsonKey(name: "fajr_jamah")
  final DateTime fajrIqamah;

  @JsonKey(name: "sunrise")
  final DateTime sunrise;

  @JsonKey(name: "zuhr_begins")
  final DateTime zuhrAzan;
  @JsonKey(name: "zuhr_jamah")
  final DateTime zuhrIqamah;

  @JsonKey(name: "asr_mithl_1")
  final DateTime asrAzan;
  @JsonKey(name: "asr_mithl_2")
  final DateTime asrAzan2;
  @JsonKey(name: "asr_jamah")
  final DateTime asrIqamah;

  @JsonKey(name: "maghrib_begins")
  final DateTime maghribAzan;
  @JsonKey(name: "maghrib_jamah")
  final DateTime maghribIqamah;

  @JsonKey(name: "isha_begins")
  final DateTime ishaAzan;
  @JsonKey(name: "isha_jamah")
  final DateTime ishaIqamah;

  ApiPrayerTime({
    required this.date,
    required this.fajrAzan,
    required this.fajrIqamah,
    required this.sunrise,
    required this.zuhrAzan,
    required this.zuhrIqamah,
    required this.asrAzan,
    required this.asrAzan2,
    required this.asrIqamah,
    required this.maghribAzan,
    required this.maghribIqamah,
    required this.ishaAzan,
    required this.ishaIqamah,
  });

  factory ApiPrayerTime.fromJson(Map<String, dynamic> json) =>
      _$ApiPrayerTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ApiPrayerTimeToJson(this);
}
