import 'dart:math';

import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';

@lazySingleton
class PrayerTimesRemoteSource {
  final Clock _clock;
  final McndApi _api;
  final Mapper _mapper;

  PrayerTimesRemoteSource(this._api, this._mapper, this._clock);

  Future<List<DayPrayers>> fetchThisMonthPrayers() async {
    return (await _api.getPrayerTime(PrayerTimeFilter.month)).map((e) => _mapper.mapApiPrayerTime(e)).toList();
  }

  Future<List<DayPrayers>> fetchAheadPrayers(int daysAhead) async {
    final DateTime nowDate = _clock.now();

    final List<DayPrayers> monthDailyPrayers = await fetchThisMonthPrayers();

    final startIndex = monthDailyPrayers.findIndexForDate(nowDate);
    final endIndex = min(startIndex + daysAhead, monthDailyPrayers.length);

    return monthDailyPrayers.sublist(startIndex, endIndex);
  }
}
