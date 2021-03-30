import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';

part 'prayer_times_model.freezed.dart';

@freezed
abstract class PrayerTimesModel with _$PrayerTimesModel {
  const factory PrayerTimesModel.loading() = Loading;
  const factory PrayerTimesModel.error(String error) = Error;
  const factory PrayerTimesModel.loaded(PrayerTime prayerTime) = Loaded;
}
