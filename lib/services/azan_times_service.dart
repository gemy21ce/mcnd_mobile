import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
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
    final List<ApiPrayerTime> apiRes = await _api.getPrayerTime(PrayerTimeFilter.today);
    final prayerTime = _mapper.mapApiPrayerTime(apiRes.first);
    _localNotificationsService.scheduleAzans(prayerTime.times);
    return prayerTime;
  }
}
