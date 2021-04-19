import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';

mixin ApiPrayerTimeMapper {
  DayPrayers mapApiPrayerTime(ApiPrayerTime apiModel) {
    final Map<Salah, SalahTime> times = {
      Salah.fajr: SalahTime(
        apiModel.fajrAzan.matchDateWith(apiModel.date),
        apiModel.fajrIqamah.matchDateWith(apiModel.date),
      ),
      Salah.sunrise: SalahTime(
        apiModel.sunrise.matchDateWith(apiModel.date),
      ),
      Salah.zuhr: SalahTime(
        apiModel.zuhrAzan.matchDateWith(apiModel.date),
        apiModel.zuhrIqamah.matchDateWith(apiModel.date),
      ),
      Salah.asr: SalahTime(
        apiModel.asrAzan.matchDateWith(apiModel.date),
        apiModel.asrIqamah.matchDateWith(apiModel.date),
      ),
      Salah.maghrib: SalahTime(
        apiModel.maghribAzan.matchDateWith(apiModel.date),
        apiModel.maghribIqamah.matchDateWith(apiModel.date),
      ),
      Salah.isha: SalahTime(
        apiModel.ishaAzan.matchDateWith(apiModel.date),
        apiModel.ishaIqamah.matchDateWith(apiModel.date),
      ),
    };

    return DayPrayers(
      apiModel.date,
      times,
    );
  }
}
