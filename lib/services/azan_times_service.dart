import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';

@lazySingleton
class AzanTimesService {
  final McndApi _api;
  final LocalNotificationsService _localNotificationsService;
  final Mapper _mapper;

  AzanTimesService(
    this._api,
    this._localNotificationsService,
    this._mapper,
  );

  /// fetch prayer times for the day and schedule azan notifications
  Future<DayPrayers> fetchPrayerTimeForTheDay() async {
    final DateTime nowDate = DateTime.now();

    final List<DayPrayers> monthDailyPrayers =
        (await _api.getPrayerTime(PrayerTimeFilter.month)).map((e) => _mapper.mapApiPrayerTime(e)).toList();

    final todayPrayerTimes = monthDailyPrayers.where((dayTimes) {
      final DateTime dayDate = dayTimes.date;
      return dayDate.year == nowDate.year && dayDate.month == nowDate.month && dayDate.day == nowDate.day;
    }).first;

    await _scheduleAzansStartingFrom(monthDailyPrayers, todayPrayerTimes);

    return todayPrayerTimes;
  }

  Future<void> _scheduleAzansStartingFrom(List<DayPrayers> times, DayPrayers start, [int daysToSchedule = 10]) async {
    final startIndex = times.indexOf(start);
    final endIndex = min(startIndex + daysToSchedule, times.length);
    final List<Map<Salah, DateTime>> azansToSchedule = [];

    for (int i = startIndex; i < endIndex; i++) {
      final dayTimes = times[i];
      azansToSchedule.add(dayTimes.times.map((key, value) => MapEntry(key, value.azan)));
    }

    await _localNotificationsService.scheduleDaysAzans(azansToSchedule);
  }
}
