import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/app/day_prayer.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/network/prayer_times_remote_source.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';

@lazySingleton
class AzanTimesService {
  final PrayerTimesRemoteSource _prayerTimesRemoteSource;
  final LocalNotificationsService _localNotificationsService;

  AzanTimesService(
    this._prayerTimesRemoteSource,
    this._localNotificationsService,
  );

  /// fetch prayer times for the day and schedule azan notifications
  Future<DayPrayers> fetchTodayPrayersAndScheduleAheadNotifications() async {
    final List<DayPrayers> prayers = await _prayerTimesRemoteSource.fetchAheadPrayers(10);

    final List<Map<Salah, DateTime>> toSchedule =
        prayers.map((p) => p.times.map((key, value) => MapEntry(key, value.azan))).toList();

    _localNotificationsService.scheduleDaysAzans(toSchedule);

    return prayers.first;
  }
}
