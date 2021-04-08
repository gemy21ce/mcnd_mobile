import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mcnd_mobile/data/models/app/azan_notification_payload.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:timezone/timezone.dart' as tz;

@lazySingleton
class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _plugin;
  final Logger _logger;

  LocalNotificationsService(this._plugin, this._logger);

  bool _initialized = false;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('app_icon');

    const iosInit = IOSInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _plugin.initialize(
      initializationSettings,
    );

    await _plugin.initialize(initializationSettings);

    _initialized = true;
  }

  Future<void> scheduleAzan(Salah salah, SalahTime salahTime) async {
    final String salahName = salah.getStringName();

    if (await isAzanScheduled(salah, salahTime)) {
      _logger.i('Salah $salahName at ${salahTime.azan} is already scheduled');
      return;
    }

    final int id = Random().nextInt(1024 * 1024);
    final DateTime dateTime = salahTime.azan;
    final AzanNotificationPayload payload = AzanNotificationPayload(
      id: id,
      salah: salah,
      dateTime: dateTime,
    );

    await _plugin.zonedSchedule(
      id,
      '$salahName Azan',
      'Time for ${salahName.toLowerCase()} salah',
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'azan',
          'Azan Notifications',
          'MCND azan notification channel',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: json.encode(payload.toJson()),
    );

    _logger.i('Scheduled a notification for $salahName azan at $dateTime');
  }

  Future<bool> isAzanScheduled(Salah salah, SalahTime salahTime) async {
    final List<AzanNotificationPayload> notifications = await getScheduledAzans();
    return notifications
        .where(
          (notification) => notification.dateTime == salahTime.azan && notification.salah == salah,
        )
        .isNotEmpty;
  }

  Future<List<AzanNotificationPayload>> getScheduledAzans() async {
    final List<PendingNotificationRequest> pendingRequests = await _plugin.pendingNotificationRequests();
    final a = pendingRequests
        .where((r) => r.payload != null)
        .map<AzanNotificationPayload?>((r) {
          try {
            return AzanNotificationPayload.fromJson(json.decode(r.payload!) as Map<String, dynamic>);
          } catch (e, stk) {
            _logger.w("Payload couldn't be serialized to type $AzanNotificationPayload", e, stk);
            return null;
          }
        })
        .where((r) => r != null)
        .map((e) => e!)
        .toList();
    return a;
  }
}
