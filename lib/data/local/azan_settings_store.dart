import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

const defaultAzanSettingsValue = {
  Salah.fajr: AzanNotificationSetting.short,
  Salah.sunrise: AzanNotificationSetting.silent,
  Salah.zuhr: AzanNotificationSetting.short,
  Salah.asr: AzanNotificationSetting.short,
  Salah.maghrib: AzanNotificationSetting.short,
  Salah.isha: AzanNotificationSetting.short,
};

@lazySingleton
class AzanSettingsStore {
  static const settingsKey = 'azan_settings';
  final SharedPreferences _sharedPreferences;

  AzanSettingsStore(this._sharedPreferences);

  AzanNotificationSetting getNotificationSettingsForSalah(Salah salah) {
    final String key = notificationSettingsKeyForSalah(salah);
    final int? id = _sharedPreferences.getInt(key);

    if (id == null) {
      return defaultAzanSettingsValue[salah]!;
    }

    return AzanNotificationSettingExt.fromId(id);
  }

  Future<void> setNotificationSettingsForSalah(Salah salah, AzanNotificationSetting setting) async {
    final String key = notificationSettingsKeyForSalah(salah);
    await _sharedPreferences.setInt(key, setting.getId());
  }

  @visibleForTesting
  String notificationSettingsKeyForSalah(Salah salah) => '$settingsKey.${salah.getId()}';
}
