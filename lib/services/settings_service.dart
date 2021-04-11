import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/settings.dart';

const defaultSettingsValue = Settings(
  azanSettings: {
    Salah.fajr: AzanNotificationSetting.short,
    Salah.sunrise: AzanNotificationSetting.silent,
    Salah.zuhr: AzanNotificationSetting.short,
    Salah.asr: AzanNotificationSetting.short,
    Salah.maghrib: AzanNotificationSetting.short,
    Salah.isha: AzanNotificationSetting.short,
  },
);

@lazySingleton
class SettingsService {
  static const _settingsKey = '_settingsKey';
  final Box<Settings> _settingsBox;

  SettingsService(this._settingsBox);

  Map<Salah, AzanNotificationSetting> getAzanNotificationSettings() {
    return _settingsBox.get(_settingsKey, defaultValue: defaultSettingsValue)!.azanSettings;
  }
}
