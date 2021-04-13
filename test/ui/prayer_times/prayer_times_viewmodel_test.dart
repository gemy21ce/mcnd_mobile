import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../_test_shared/api_response.dart';
import '../prayer_times/prayer_times_viewmodel_test.mocks.dart';

@GenerateMocks([
  McndApi,
  Mapper,
], customMocks: [
  MockSpec<LocalNotificationsService>(returnNullOnMissingStub: true),
  MockSpec<PrayerTime>(returnNullOnMissingStub: true),
  MockSpec<ApiPrayerTime>(returnNullOnMissingStub: true),
])
void main() {
  final api = MockMcndApi();
  final mapper = MockMapper();
  final localNotificationService = MockLocalNotificationsService();
  final vm = PrayerTimesViewModel(api, mapper, localNotificationService);

  tearDown(() {
    reset(api);
    reset(mapper);
  });

  test('start in loading state', () {
    expect(vm.debugState, const PrayerTimesModel.loading());
  });

  test('when api fails state is error', () async {
    const error = 'this is an error';

    when(api.getPrayerTime(any)).thenAnswer(
      (_) => Future.error(error),
    );

    await vm.fetchTimes();

    expect(vm.debugState, const PrayerTimesModel.error(error));
  });

  test('when api returns result state is loaded and will schedule azan notifications', () async {
    final apiResult = [ApiPrayerTime.fromJson(apiPrayerDayResponse)];
    final model = const Mapper().mapApiPrayerTime(apiResult.first);

    when(api.getPrayerTime(any)).thenAnswer(
      (_) async => apiResult,
    );

    when(mapper.mapApiPrayerTime(any)).thenReturn(const Mapper().mapApiPrayerTime(apiResult.first));

    await vm.fetchTimes();

    verify(mapper.mapApiPrayerTime(argThat(equals(apiResult.first))));
    verify(localNotificationService.scheduleAzans(model.times));
  });
}
