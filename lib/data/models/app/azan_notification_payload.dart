import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';

part 'azan_notification_payload.freezed.dart';
part 'azan_notification_payload.g.dart';

@freezed
class AzanNotificationPayload with _$AzanNotificationPayload {
  factory AzanNotificationPayload({
    required int id,
    required Salah salah,
    required DateTime dateTime,
  }) = _AzanNotificationPayload;

  factory AzanNotificationPayload.fromJson(Map<String, dynamic> json) => _$AzanNotificationPayload(json);
}
