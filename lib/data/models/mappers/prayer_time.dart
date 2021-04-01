import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';

import 'mapper.dart';

extension MapperPrayerTime on Mapper {
  PrayerTime mapApiPrayerTime(ApiPrayerTime apiModel) {
    final times = <Salah, SalahTime>{
      Salah.FAJR: SalahTime(
        apiModel.fajrAzan,
        apiModel.asrIqamah,
      ),
      Salah.ZUHR: SalahTime(
        apiModel.zuhrAzan,
        apiModel.zuhrIqamah,
      ),
      Salah.ASR: SalahTime(
        apiModel.asrAzan,
        apiModel.asrIqamah,
      ),
      Salah.MAGHRIB: SalahTime(
        apiModel.maghribAzan,
        apiModel.maghribIqamah,
      ),
      Salah.ISHA: SalahTime(
        apiModel.ishaAzan,
        apiModel.ishaIqamah,
      ),
    };

    return PrayerTime(
      apiModel.date,
      times,
      apiModel.sunrise,
    );
  }
}
