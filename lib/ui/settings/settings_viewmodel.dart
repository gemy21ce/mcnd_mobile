import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/settings.dart';
import 'package:mcnd_mobile/services/settings_service.dart';
import 'package:mcnd_mobile/ui/settings/settings_model.dart';

@injectable
class SettingsViewModel extends StateNotifier<SettingsModel?> {
  final SettingsService _settingsService;

  SettingsViewModel(this._settingsService) : super(null);

  void load() {
    final Map<Salah, AzanNotificationSetting> azanNotificationSettings = _settingsService.getAzanNotificationSettings();
    state = SettingsModel(
      azanSettingsOptions: AzanNotificationSetting.values.map((e) => e.getStringName()).toList(),
      azanSettingsItems: azanNotificationSettings.entries.map((e) {
        final Salah salah = e.key;
        final AzanNotificationSetting setting = e.value;
        return AzanSettingsItem(
          salahName: salah.getStringName(),
          selectedSetting: setting.index,
        );
      }).toList(),
    );
  }
}
