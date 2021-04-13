import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';
import 'package:mcnd_mobile/services/azan_settings_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'azan_settings_service_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  test('getNotificationSettingsForSalah will return the default if not found', () {
    final prefs = MockSharedPreferences();
    final service = AzanSettingsService(prefs);

    when(prefs.getInt(any)).thenReturn(null);

    final setting = service.getNotificationSettingsForSalah(Salah.sunrise);

    expect(setting, equals(defaultAzanSettingsValue[Salah.sunrise]));
  });

  test('getNotificationSettingsForSalah will return stored value', () {
    final prefs = MockSharedPreferences();
    final service = AzanSettingsService(prefs);

    when(prefs.getInt(any)).thenReturn(AzanNotificationSetting.full.getId());

    final setting = service.getNotificationSettingsForSalah(Salah.zuhr);

    expect(setting, equals(AzanNotificationSetting.full));
  });

  test('setNotificationSettingsForSalah will set value', () {
    final prefs = MockSharedPreferences();
    final service = AzanSettingsService(prefs);

    when(prefs.setInt(any, any)).thenAnswer((realInvocation) async => true);

    service.setNotificationSettingsForSalah(
      Salah.maghrib,
      AzanNotificationSetting.silent,
    );

    verify(prefs.setInt(
      service.notificationSettingsKeyForSalah(Salah.maghrib),
      AzanNotificationSetting.silent.getId(),
    ));
  });

  test('notificationSettingsKeyForSalah will be unique for every salah', () {
    final prefs = MockSharedPreferences();
    final service = AzanSettingsService(prefs);

    final keys = Salah.values.map((e) => service.notificationSettingsKeyForSalah(e)).toList();
    final noDups = Set.of(keys).toList();

    expect(noDups.length, equals(keys.length));
  });
}
