import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

import '../../../_test_shared/api_response.dart';

main() {
  test("mapApiPrayerTime", () {
    final apiRes = ApiPrayerTime.fromJson(apiPrayerDayResponse);
    final mapped = Mapper().mapApiPrayerTime(apiRes);

    expect(mapped.date, apiRes.date);
    expect(mapped.sunrise, apiRes.sunrise);

    //test only few ones
    expect(mapped.times[Salah.FAJR]!.azan,
        apiRes.fajrAzan.matchDateWith(apiRes.date));

    expect(mapped.times[Salah.FAJR]!.iqamah,
        apiRes.fajrIqamah.matchDateWith(apiRes.date));

    expect(mapped.times[Salah.ASR]!.azan,
        apiRes.asrAzan.matchDateWith(apiRes.date));

    expect(mapped.times[Salah.MAGHRIB]!.iqamah,
        apiRes.maghribIqamah.matchDateWith(apiRes.date));

    expect(mapped.times[Salah.ISHA]!.azan,
        apiRes.ishaAzan.matchDateWith(apiRes.date));
  });
}
