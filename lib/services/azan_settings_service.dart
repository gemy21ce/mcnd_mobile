import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/local/azan_settings_store.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';

@lazySingleton
class AzanSettingsService {
  final LocalNotificationsService _localNotificationsService;
  final AzanSettingsStore _azanSettingsStore;

  AzanSettingsService(this._localNotificationsService, this._azanSettingsStore);

  AzanNotificationSetting getNotificationSettingsForSalah(Salah salah) {
    return _azanSettingsStore.getNotificationSettingsForSalah(salah);
  }

  Future<void> setNotificationSettingsForSalah(Salah salah, AzanNotificationSetting setting) async {
    await _azanSettingsStore.setNotificationSettingsForSalah(salah, setting);
    _localNotificationsService.updateScheduledAzansToMatchSettings();
  }
}
