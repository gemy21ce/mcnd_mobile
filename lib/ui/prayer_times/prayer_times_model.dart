import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';

part 'prayer_times_model.freezed.dart';


@freezed
abstract class PrayerTimesModel with _$PrayerTimesModel {
  const factory PrayerTimesModel.loading() = Loading;
  const factory PrayerTimesModel.error(String error) = Error;
  const factory PrayerTimesModel.loaded(PrayerTimesModelData data) = Loaded;
}


@freezed
abstract class PrayerTimesModelData with _$PrayerTimesModelData {
  const factory PrayerTimesModelData({
    required String date,
    required String hijriDate,
    required String upcommingSalah,
    required String timeToUpcommingSalah,
    required List<PrayerTimesModelItem> times,
  }) = _PrayerTimesModelData;
}

@freezed
abstract class PrayerTimesModelItem with _$PrayerTimesModelItem {
  const factory PrayerTimesModelItem({
    required String prayerName,
    required String begins,
    required String iqamah,
    @Default(false) bool highlight,
  }) = _PrayerTimesModelItem;
}
