import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';
import 'package:mcnd_mobile/data/network/prayer_times_remote_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../_test_shared/api_response.dart';
import 'prayer_times_remote_source_test.mocks.dart';

@GenerateMocks([McndApi, Clock])
void main() {
  test('test fetch timetable at the end of the month', () async {
    final api = MockMcndApi();
    const mapper = Mapper();
    final clock = MockClock();
    when(clock.now()).thenReturn(DateTime(2021, 5, 25));

    final may = ((await apiPrayerMonthResponse as List)[0] as List)
        .map((dynamic e) => ApiPrayerTime.fromJson(e as Map<String, dynamic>))
        .toList();

    when(api.getPrayerTime(PrayerTimeFilter.month)).thenAnswer((_) async {
      return Future.value(may);
    });

    final year = ((await apiPrayerYearResponse as List)[0] as List)
        .map((dynamic e) => ApiPrayerTime.fromJson(e as Map<String, dynamic>))
        .toList();

    when(api.getPrayerTime(PrayerTimeFilter.year)).thenAnswer((_) async {
      return Future.value(year);
    });

    final PrayerTimesRemoteSource source = PrayerTimesRemoteSource(api, mapper, clock);

    final prayers = await source.fetchAheadPrayers(10);

    expect(prayers.length, 10);
    expect(prayers[0].date.day, 25);
    expect(prayers[0].date.month, 5);
    expect(prayers[1].date.day, 26);
    expect(prayers[1].date.month, 5);
    expect(prayers[2].date.day, 27);
    expect(prayers[2].date.month, 5);
    expect(prayers[3].date.day, 28);
    expect(prayers[3].date.month, 5);
    expect(prayers[4].date.day, 29);
    expect(prayers[4].date.month, 5);
    expect(prayers[5].date.day, 30);
    expect(prayers[5].date.month, 5);
    expect(prayers[6].date.day, 31);
    expect(prayers[6].date.month, 5);
    expect(prayers[7].date.day, 1);
    expect(prayers[7].date.month, 6);
    expect(prayers[8].date.day, 2);
    expect(prayers[8].date.month, 6);
    expect(prayers[9].date.day, 3);
    expect(prayers[9].date.month, 6);

  });
}
