import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
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

  final Map<int, AzanNotificationPayload> _scheduledAzansCache = {};
  final DateFormat notificationIdDatePartFormat = DateFormat('yyyyMMdd');

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

  Future<void> scheduleAzans(Map<Salah, SalahTime> azans) async {
    for (final e in azans.entries) {
      await scheduleAzan(e.key, e.value, updateCache: false);
    }
    updateScheduledAzansCache();
  }

  Future<void> scheduleAzan(Salah salah, SalahTime salahTime, {bool updateCache = true}) async {
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

    if (updateCache) {
      updateScheduledAzansCache();
    }
  }

  Future<bool> isAzanScheduled(Salah salah, SalahTime salahTime, {bool forceUpdate = false}) async {
    if (_scheduledAzansCache.isEmpty || forceUpdate) {
      await updateScheduledAzansCache();
    }

    final date = salahTime.azan; // we will only use the date part, not time
    return _scheduledAzansCache.containsKey(getIdForSalah(salah, date));
  }

  int getIdForSalah(Salah salah, DateTime date) {
    final String datePart = notificationIdDatePartFormat.format(date);
    final String idString = '$datePart${salah.getId()}';
    return int.parse(idString);
  }

  Future<void> updateScheduledAzansCache() async {
    final List<PendingNotificationRequest> pendingRequests = await _plugin.pendingNotificationRequests();
    final List<AzanNotificationPayload> scheduledAzans = pendingRequests
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

    _scheduledAzansCache.clear();
    _scheduledAzansCache.addEntries(scheduledAzans.map((e) => MapEntry(e.id, e)));
  }
}
