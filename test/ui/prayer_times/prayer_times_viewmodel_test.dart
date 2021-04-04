import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../prayer_times/prayer_times_viewmodel_test.mocks.dart';

@GenerateMocks([McndApi, Mapper, PrayerTimesModel, ApiPrayerTime, PrayerTime])
main() {
  final api = MockMcndApi();
  final mapper = MockMapper();
  final vm = PrayerTimesViewModel(api, mapper);

  tearDown(() {
    reset(api);
    reset(mapper);
  });

  test("start in loading state", () {
    expect(vm.debugState, PrayerTimesModel.loading());
  });

  test("when api fails state is error", () async {
    final error = "this is an error";

    when(api.getPrayerTime(any)).thenAnswer(
      (_) => Future.error(error),
    );

    await vm.fetchTimes();

    expect(vm.debugState, PrayerTimesModel.error(error));
  });

  test("when api returns result state is loaded", () async {
    final apiResult = [MockApiPrayerTime()];
    final mapperResult = MockPrayerTime();

    when(api.getPrayerTime(any)).thenAnswer(
      (_) async => apiResult,
    );

    when(mapper.mapApiPrayerTime(any)).thenReturn(mapperResult);

    await vm.fetchTimes();

    verify(mapper.mapApiPrayerTime(argThat(equals(apiResult.first))));
  });
}
