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

    final todayIndex = prayerTimeForTheMonth.indexOf(todayPrayerTimes);
    final lastScheduleDayIndex = min(todayIndex + 10, prayerTimeForTheMonth.length);
    final List<Map<Salah, SalahTime>> azansToSchedule = [];

    for (int i = todayIndex; i < lastScheduleDayIndex; i++) {
      final dayTimes = prayerTimeForTheMonth[i];
      azansToSchedule.add(dayTimes.times);
    }

    _localNotificationsService.scheduleAzansForMultipleDays(azansToSchedule);

    return todayPrayerTimes;
  }
}
