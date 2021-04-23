import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/local/azan_settings_store.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';
import 'package:mcnd_mobile/services/azan_settings_service.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'azan_settings_service_test.mocks.dart';

@GenerateMocks([LocalNotificationsService, AzanSettingsStore])
void main() {
  test('getNotificationSettingsForSalah', () {
    final localNotificationsService = MockLocalNotificationsService();
    final azanSettingsStore = MockAzanSettingsStore();
    final service = AzanSettingsService(localNotificationsService, azanSettingsStore);

    const expectedSettings = AzanNotificationSetting.short;
    when(azanSettingsStore.getNotificationSettingsForSalah(any)).thenReturn(expectedSettings);

    const salah = Salah.sunrise;
    final settings = service.getNotificationSettingsForSalah(salah);

    expect(settings, expectedSettings);
    verify(azanSettingsStore.getNotificationSettingsForSalah(salah));
  });

  test('setNotificationSettingsForSalah', () async {
    final localNotificationsService = MockLocalNotificationsService();
    final azanSettingsStore = MockAzanSettingsStore();
    final service = AzanSettingsService(localNotificationsService, azanSettingsStore);

    when(azanSettingsStore.setNotificationSettingsForSalah(any, any)).thenAnswer((_) async {});
    when(localNotificationsService.updateScheduledAzansToMatchSettings()).thenAnswer((_) async {});

    const salah = Salah.fajr;
    const setting = AzanNotificationSetting.full;
    await service.setNotificationSettingsForSalah(salah, setting);

    verify(azanSettingsStore.setNotificationSettingsForSalah(salah, setting));
    verify(localNotificationsService.updateScheduledAzansToMatchSettings());
  });
}
