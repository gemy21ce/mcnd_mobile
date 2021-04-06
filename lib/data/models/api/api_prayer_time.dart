import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mcnd_mobile/data/models/mcnd_datetime_converter.dart';

part 'api_prayer_time.freezed.dart';
part 'api_prayer_time.g.dart';

@freezed
class ApiPrayerTime with _$ApiPrayerTime {
  @McndTimeConverter()
  factory ApiPrayerTime({
    @JsonKey(name: 'd_date') @McndDateConverter() required DateTime date,
    @JsonKey(name: 'fajr_begins') required DateTime fajrAzan,
    @JsonKey(name: 'fajr_jamah') required DateTime fajrIqamah,
    @JsonKey(name: 'sunrise') required DateTime sunrise,
    @JsonKey(name: 'zuhr_begins') required DateTime zuhrAzan,
    @JsonKey(name: 'zuhr_jamah') required DateTime zuhrIqamah,
    @JsonKey(name: 'asr_mithl_1') required DateTime asrAzan,
    @JsonKey(name: 'asr_mithl_2') required DateTime asrAzan2,
    @JsonKey(name: 'asr_jamah') required DateTime asrIqamah,
    @JsonKey(name: 'maghrib_begins') required DateTime maghribAzan,
    @JsonKey(name: 'maghrib_jamah') required DateTime maghribIqamah,
    @JsonKey(name: 'isha_begins') required DateTime ishaAzan,
    @JsonKey(name: 'isha_jamah') required DateTime ishaIqamah,
  }) = _ApiPrayerTime;

  factory ApiPrayerTime.fromJson(Map<String, dynamic> json) => _$ApiPrayerTimeFromJson(json);
}
