import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/app/day_prayer.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:mcnd_mobile/data/network/prayer_times_remote_source.dart';
import 'package:mcnd_mobile/services/azan_times_service.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'azan_times_service_test.mocks.dart';

@GenerateMocks([Clock, PrayerTimesRemoteSource, LocalNotificationsService])
void main() {
  group('fetchTodayPrayersAndScheduleAheadNotifications', () {
    test('currentTime is before isha will return today', () async {
      final prayerTimesRemoteSource = MockPrayerTimesRemoteSource();
      final localNotificationsService = MockLocalNotificationsService();
      final clock = Clock.fixed(DateTime(2011, 10, 10, 10, 10));

      final service = AzanTimesService(
          prayerTimesRemoteSource, localNotificationsService, clock);

      final ishaTime = DateTime(2011, 10, 10, 20, 10);

      final today = DayPrayers(
        DateTime.now(),
        {Salah.isha: SalahTime(ishaTime, ishaTime)},
      );

      final tomorrow = DayPrayers(
        DateTime.now(),
        {Salah.isha: SalahTime(DateTime.now(), DateTime.now())},
      );

      when(prayerTimesRemoteSource.fetchAheadPrayers(any))
          .thenAnswer((realInvocation) async => [today, tomorrow]);

      when(localNotificationsService.scheduleDaysAzans(any))
          .thenAnswer((realInvocation) async {});

      final prayers =
          await service.fetchTodayPrayersAndScheduleAheadNotifications();

      expect(prayers, today);

      verify(prayerTimesRemoteSource.fetchAheadPrayers(10));
      verify(localNotificationsService.scheduleDaysAzans(any));
    });

    test('currentTime is after isha will return next day', () async {
      final prayerTimesRemoteSource = MockPrayerTimesRemoteSource();
      final localNotificationsService = MockLocalNotificationsService();
      final clock = Clock.fixed(DateTime(2011, 10, 10, 22, 10));

      final service = AzanTimesService(
          prayerTimesRemoteSource, localNotificationsService, clock);

      final ishaTime = DateTime(2011, 10, 10, 20, 10);

      final today = DayPrayers(
        DateTime.now(),
        {Salah.isha: SalahTime(ishaTime, ishaTime)},
      );

      final tomorrow = DayPrayers(
        DateTime.now(),
        {Salah.isha: SalahTime(DateTime.now(), DateTime.now())},
      );

      when(prayerTimesRemoteSource.fetchAheadPrayers(any))
          .thenAnswer((realInvocation) async => [today, tomorrow]);

      when(localNotificationsService.scheduleDaysAzans(any))
          .thenAnswer((realInvocation) async {});

      final prayers =
          await service.fetchTodayPrayersAndScheduleAheadNotifications();

      expect(prayers, tomorrow);

      verify(prayerTimesRemoteSource.fetchAheadPrayers(10));
      verify(localNotificationsService.scheduleDaysAzans(any));
    });
  });
}
