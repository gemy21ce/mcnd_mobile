import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
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
  Future<PrayerTime> fetchPrayerTimeForTheDay() async {
    final DateTime nowDate = DateTime.now();

    final List<PrayerTime> prayerTimeForTheMonth =
        (await _api.getPrayerTime(PrayerTimeFilter.month)).map((e) => _mapper.mapApiPrayerTime(e)).toList();

    final todayPrayerTimes = prayerTimeForTheMonth.where((dayTimes) {
      final DateTime dayDate = dayTimes.date;
      return dayDate.year == nowDate.year && dayDate.month == nowDate.month && dayDate.day == nowDate.day;
    }).first;

    await _scheduleAzansStartingFrom(prayerTimeForTheMonth, todayPrayerTimes);

    return todayPrayerTimes;
  }

  Future<void> _scheduleAzansStartingFrom(List<PrayerTime> times, PrayerTime start, [int daysToSchedule = 10]) async {
    final startIndex = times.indexOf(start);
    final endIndex = min(startIndex + daysToSchedule, times.length);
    final List<Map<Salah, SalahTime>> azansToSchedule = [];

    for (int i = startIndex; i < endIndex; i++) {
      final dayTimes = times[i];
      azansToSchedule.add(dayTimes.times);
    }

    await _localNotificationsService.scheduleAzansForMultipleDays(azansToSchedule);
  }
}
