import 'package:enum_to_string/enum_to_string.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/settings.dart';
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
class AzanSettingsService {
  static const settingsKey = 'azan_settings';
  final SharedPreferences _sharedPreferences;

  AzanSettingsService(this._sharedPreferences);

  AzanNotificationSetting getNotificationSettingsForSalah(Salah salah) {
    final String key = _notificationSettingsKeyForSalah(salah);
    final int? id = _sharedPreferences.getInt(key);

    if (id == null) {
      return defaultAzanSettingsValue[salah]!;
    }

    return AzanNotificationSettingExt.fromId(id);
  }

  Future<void> setNotificationSettingsForSalah(Salah salah, AzanNotificationSetting setting) async {
    final String key = _notificationSettingsKeyForSalah(salah);
    await _sharedPreferences.setInt(key, setting.getId());
  }

  String _notificationSettingsKeyForSalah(Salah salah) => '$settingsKey.${EnumToString.convertToString(salah)}';
}
