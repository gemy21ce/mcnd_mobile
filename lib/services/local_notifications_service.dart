import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mcnd_mobile/data/models/app/azan_notification_payload.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';
import 'package:mcnd_mobile/services/azan_settings_service.dart';
import 'package:timezone/timezone.dart' as tz;

@lazySingleton
class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _plugin;
  final AzanSettingsService _azanSettingsService;
  final Logger _logger;

  LocalNotificationsService(this._plugin, this._logger, this._azanSettingsService);

  bool _initialized = false;
  bool get isInitialized => _initialized;

  final Map<int, AzanNotificationPayload> _scheduledAzansCache = {};
  final DateFormat notificationIdDatePartFormat = DateFormat('yyMMdd');

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

  Future<void> scheduleAzansForMultipleDays(List<Map<Salah, SalahTime>> azans, {bool updateCache = true}) async {
    for (final dayAzans in azans) {
      await scheduleAzans(dayAzans, updateCache: false);
    }

    updateScheduledAzansCache();
  }

  Future<void> scheduleAzans(Map<Salah, SalahTime> azans, {bool updateCache = true}) async {
    for (final e in azans.entries) {
      await scheduleAzan(e.key, e.value, updateCache: false);
    }

    if (updateCache) {
      updateScheduledAzansCache();
    }
  }

  Future<void> scheduleAzan(Salah salah, SalahTime salahTime, {bool updateCache = true}) async {
    final String salahName = salah.getStringName();

    final AzanNotificationSetting settings = _azanSettingsService.getNotificationSettingsForSalah(salah);

    if (settings == AzanNotificationSetting.nothing) {
      _logger.i("[$settings] Didn't schedule notification for Salah $salahName");
      return;
    }

    final int id = getIdForSalah(salah, salahTime);

    if (await isAzanScheduled(salah, salahTime)) {
      _logger.i('[ID:$id] Salah $salahName at ${salahTime.azan} is already scheduled');
      return;
    }

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
      getNotificationDetails(setting),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: json.encode(payload.toJson()),
    );

    _logger.i('[ID:$id] Scheduled a notification for $salahName azan at $dateTime');

    if (updateCache) {
      updateScheduledAzansCache();
    }
  }

  NotificationDetails getNotificationDetails(AzanNotificationSetting setting) {
    const String channelId = 'azan';
    const String channelName = 'Azan Notifications';
    const String channelDescription = 'MCND Azan Notifications';
    const priority = Priority.high;
    const playSound = true;

    final android = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      priority: priority,
      playSound: playSound,
    );

    final ios = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: playSound,
    );

    return NotificationDetails(
      android: android,
    );
  }

  Future<bool> isAzanScheduled(Salah salah, SalahTime salahTime, {bool forceUpdate = false}) async {
    if (_scheduledAzansCache.isEmpty || forceUpdate) {
      await updateScheduledAzansCache();
    }

    return _scheduledAzansCache.containsKey(getIdForSalah(salah, salahTime));
  }

  int getIdForSalah(Salah salah, SalahTime salahTime) {
    final date = salahTime.azan; // we will only use the date part, not time

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
