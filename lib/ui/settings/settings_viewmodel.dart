import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/settings.dart';
import 'package:mcnd_mobile/services/azan_settings_service.dart';
import 'package:mcnd_mobile/ui/settings/settings_model.dart';

@injectable
class SettingsViewModel extends StateNotifier<SettingsModel?> {
  final AzanSettingsService _settingsService;

  SettingsViewModel(this._settingsService) : super(null);

  void load() {
    final azanSettingsOptions = AzanNotificationSetting.values
        .where((e) {
          if (Platform.isIOS && e == AzanNotificationSetting.full) {
            return false;
          }
          return true;
        })
        .map((e) => e.getStringName())
        .toList();

    final azanSettingsItems = Salah.values.map((salah) {
      final AzanNotificationSetting setting = _settingsService.getNotificationSettingsForSalah(salah);
      return AzanSettingsItem(
        salah: salah,
        salahName: salah.getStringName(),
        selectedSetting: setting.index,
      );
    }).toList();

    state = SettingsModel(
      azanSettingsOptions: azanSettingsOptions,
      azanSettingsItems: azanSettingsItems,
    );
  }

  void changeAzanSettings(Salah salah, int selectedIndex) {
    _settingsService.setNotificationSettingsForSalah(salah, AzanNotificationSetting.values[selectedIndex]);
    load();
  }
}
