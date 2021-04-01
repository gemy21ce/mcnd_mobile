import 'package:flutter/material.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';

import 'mapper.dart';

extension MapperPrayerTime on Mapper {
  PrayerTime mapApiPrayerTime(ApiPrayerTime apiModel) {
    final times = <Salah, SalahTime>{
      Salah.FAJR: SalahTime(
        apiModel.fajrAzan.matchDateWith(apiModel.date),
        apiModel.asrIqamah.matchDateWith(apiModel.date),
      ),
      Salah.ZUHR: SalahTime(
        apiModel.zuhrAzan.matchDateWith(apiModel.date),
        apiModel.zuhrIqamah.matchDateWith(apiModel.date),
      ),
      Salah.ASR: SalahTime(
        apiModel.asrAzan.matchDateWith(apiModel.date),
        apiModel.asrIqamah.matchDateWith(apiModel.date),
      ),
      Salah.MAGHRIB: SalahTime(
        apiModel.maghribAzan.matchDateWith(apiModel.date),
        apiModel.maghribIqamah.matchDateWith(apiModel.date),
      ),
      Salah.ISHA: SalahTime(
        apiModel.ishaAzan.matchDateWith(apiModel.date),
        apiModel.ishaIqamah.matchDateWith(apiModel.date),
      ),
    };

    return PrayerTime(
      apiModel.date,
      times,
      apiModel.sunrise,
    );
  }
}
