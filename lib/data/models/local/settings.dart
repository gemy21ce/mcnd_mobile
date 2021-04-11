import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  @HiveType(typeId: 1)
  const factory Settings({
    @HiveField(0) required Map<Salah, AzanNotificationSetting> azanSettings,
  }) = _Settings;
}

@HiveType(typeId: 2)
enum AzanNotificationSetting {
  @HiveField(0)
  nothing,
  @HiveField(1)
  silent,
  @HiveField(2)
  short,
  @HiveField(3)
  full,
}

extension AzanNotificationSettingExt on AzanNotificationSetting {
  String getStringName() {
    switch (this) {
      case AzanNotificationSetting.nothing:
        return 'No Notification';
      case AzanNotificationSetting.silent:
        return 'Silent Notification';
      case AzanNotificationSetting.short:
        return 'Short Azan';
      case AzanNotificationSetting.full:
        return 'Full Azan';
    }
  }
}
