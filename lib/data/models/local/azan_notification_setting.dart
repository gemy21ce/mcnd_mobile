import 'package:freezed_annotation/freezed_annotation.dart';

enum AzanNotificationSetting {
  @JsonValue(0)
  nothing,
  @JsonValue(1)
  silent,
  @JsonValue(2)
  short,
  @JsonValue(3)
  full,
}

extension AzanNotificationSettingExt on AzanNotificationSetting {
  /// return a constant id for each element in the enum,
  /// element id is independent from the index of the element
  int getId() {
    switch (this) {
      case AzanNotificationSetting.nothing:
        return 0;
      case AzanNotificationSetting.silent:
        return 1;
      case AzanNotificationSetting.short:
        return 2;
      case AzanNotificationSetting.full:
        return 3;
    }
  }

  /// convert id obtained from getId() back to enum element
  static AzanNotificationSetting fromId(int id) {
    switch (id) {
      case 0:
        return AzanNotificationSetting.nothing;
      case 1:
        return AzanNotificationSetting.silent;
      case 2:
        return AzanNotificationSetting.short;
      case 3:
        return AzanNotificationSetting.full;
    }
    throw 'Unknown id $id';
  }

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
