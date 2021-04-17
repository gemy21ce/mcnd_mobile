import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/local/azan_settings_store.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'azan_settings_store_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  test('getNotificationSettingsForSalah will return the default if not found', () {
    final prefs = MockSharedPreferences();
    final store = AzanSettingsStore(prefs);

    when(prefs.getInt(any)).thenReturn(null);

    final setting = store.getNotificationSettingsForSalah(Salah.sunrise);

    expect(setting, equals(defaultAzanSettingsValue[Salah.sunrise]));
  });

  test('getNotificationSettingsForSalah will return stored value', () {
    final prefs = MockSharedPreferences();
    final store = AzanSettingsStore(prefs);

    when(prefs.getInt(any)).thenReturn(AzanNotificationSetting.full.getId());

    final setting = store.getNotificationSettingsForSalah(Salah.zuhr);

    expect(setting, equals(AzanNotificationSetting.full));
  });

  test('setNotificationSettingsForSalah will set value', () {
    final prefs = MockSharedPreferences();
    final store = AzanSettingsStore(prefs);

    when(prefs.setInt(any, any)).thenAnswer((realInvocation) async => true);

    store.setNotificationSettingsForSalah(
      Salah.maghrib,
      AzanNotificationSetting.silent,
    );

    verify(prefs.setInt(
      store.notificationSettingsKeyForSalah(Salah.maghrib),
      AzanNotificationSetting.silent.getId(),
    ));
  });

  test('notificationSettingsKeyForSalah will be unique for every salah', () {
    final prefs = MockSharedPreferences();
    final store = AzanSettingsStore(prefs);

    final keys = Salah.values.map((e) => store.notificationSettingsKeyForSalah(e)).toList();
    final noDups = Set.of(keys).toList();

    expect(noDups.length, equals(keys.length));
  });
}
