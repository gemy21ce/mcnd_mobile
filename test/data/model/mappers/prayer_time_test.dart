import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

import '../../../_test_shared/api_response.dart';

void main() {
  test('mapApiPrayerTime', () {
    final apiRes = ApiPrayerTime.fromJson(apiPrayerDayResponse);
    final mapped = const Mapper().mapApiPrayerTime(apiRes);

    expect(mapped.date, apiRes.date);
    expect(mapped.sunrise, apiRes.sunrise);

    //test only few ones
    expect(mapped.times[Salah.fajr]!.azan, apiRes.fajrAzan.matchDateWith(apiRes.date));

    expect(mapped.times[Salah.fajr]!.iqamah, apiRes.fajrIqamah.matchDateWith(apiRes.date));

    expect(mapped.times[Salah.asr]!.azan, apiRes.asrAzan.matchDateWith(apiRes.date));

    expect(mapped.times[Salah.maghrib]!.iqamah, apiRes.maghribIqamah.matchDateWith(apiRes.date));

    expect(mapped.times[Salah.isha]!.azan, apiRes.ishaAzan.matchDateWith(apiRes.date));
  });
}
