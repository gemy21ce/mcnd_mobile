import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required List<String> azanSettingsOptions,
    required List<AzanSettingsItem> azanSettingsItems,
  }) = _SettingsModel;
}

@freezed
class AzanSettingsItem with _$AzanSettingsItem {
  const factory AzanSettingsItem({
    required String salahName,
    required int selectedSetting,
  }) = _AzanSettingsItem;
}
