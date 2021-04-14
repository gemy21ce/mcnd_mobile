import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';

part 'azan_notification_payload.freezed.dart';
part 'azan_notification_payload.g.dart';

@freezed
class AzanNotificationPayload with _$AzanNotificationPayload {
  factory AzanNotificationPayload({
    required int id,
    required Salah salah,
    required DateTime dateTime,
    required AzanNotificationSetting setting,
  }) = _AzanNotificationPayload;

  factory AzanNotificationPayload.fromJson(Map<String, dynamic> json) => _$AzanNotificationPayloadFromJson(json);
}
