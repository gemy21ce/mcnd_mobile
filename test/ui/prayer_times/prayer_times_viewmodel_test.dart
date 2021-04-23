import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/services/azan_times_service.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../_test_shared/api_response.dart';
import '../prayer_times/prayer_times_viewmodel_test.mocks.dart';

@GenerateMocks([
  AzanTimesService,
])
void main() {
  final azanTimesService = MockAzanTimesService();
  final vm = PrayerTimesViewModel(azanTimesService, Logger(level: Level.nothing));

  tearDown(() {
    reset(azanTimesService);
  });

  test('start in loading state', () {
    expect(vm.debugState, const PrayerTimesModel.loading());
  });

  test('when api fails state is error', () async {
    const error = 'this is an error';

    when(azanTimesService.fetchTodayPrayersAndScheduleAheadNotifications()).thenAnswer(
      (_) => Future.error(error),
    );

    await vm.fetchTimes();

    expect(vm.debugState, const PrayerTimesModel.error(error));
    verify(azanTimesService.fetchTodayPrayersAndScheduleAheadNotifications());
  });

  test('when api returns result state is loaded and will schedule azan notifications', () async {
    final apiResult = [ApiPrayerTime.fromJson(apiPrayerDayResponse)];
    //final model = const Mapper().mapApiPrayerTime(apiResult.first);

    when(azanTimesService.fetchTodayPrayersAndScheduleAheadNotifications()).thenAnswer(
      (_) async => const Mapper().mapApiPrayerTime(apiResult.first),
    );

    await vm.fetchTimes();
    expect(vm.debugState, isInstanceOf<Loaded>());
    verify(azanTimesService.fetchTodayPrayersAndScheduleAheadNotifications());
  });
}
