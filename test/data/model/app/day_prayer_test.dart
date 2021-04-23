import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/day_prayer.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

import '../../../_test_shared/api_response.dart';

final DayPrayers _sampleDayPrayers = const Mapper().mapApiPrayerTime(
  ApiPrayerTime.fromJson(apiPrayerDayResponse),
);

void main() {
  group('DayPrayersListExt', () {
    final days = <DayPrayers>[];

    // add 25 prayers with dates starting from 2015/5/1 to 2015/5/25
    const year = 2015;
    const month = 5;
    final random = Random();
    for (var day = 1; day <= 25; day++) {
      days.add(_sampleDayPrayers.copyWith(
        date: DateTime(
          year,
          month,
          day,
          // randomize time, this should have no effect on the test
          random.nextInt(24),
          random.nextInt(60),
          random.nextInt(60),
        ),
      ));
    }

    test('findPrayersForDate', () {
      final date = DateTime(year, month, 15);
      final expected = days[14];
      final result = days.findPrayersForDate(date);
      expect(result, expected);
    });

    test('findIndexForDate', () {
      final date = DateTime(year, month, 17);
      const expected = 16;
      final result = days.findIndexForDate(date);
      expect(result, expected);
    });
  });
}
