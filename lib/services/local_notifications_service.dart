import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mcnd_mobile/data/local/azan_settings_store.dart';
import 'package:mcnd_mobile/data/models/app/azan_notification_payload.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';
import 'package:timezone/timezone.dart' as tz;

@lazySingleton
class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _plugin;
  final AzanSettingsStore _azanSettingsStore;
  final Logger _logger;

  LocalNotificationsService(this._plugin, this._logger, this._azanSettingsStore);

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

  Future<void> scheduleAzansForMultipleDays(List<Map<Salah, DateTime>> azans, {bool updateCache = true}) async {
    for (final dayAzans in azans) {
      await scheduleAzans(dayAzans, updateCache: false);
    }

    updateScheduledAzansCache();
  }

  Future<void> scheduleAzans(Map<Salah, DateTime> azans, {bool updateCache = true}) async {
    for (final e in azans.entries) {
      await scheduleAzan(e.key, e.value, updateCache: false);
    }

    if (updateCache) {
      updateScheduledAzansCache();
    }
  }

  Future<void> scheduleAzan(Salah salah, DateTime salahDateTime, {bool updateCache = true}) async {
    final String salahName = salah.getStringName();

    if (salahDateTime.isBefore(DateTime.now())) {
      _logger.i("[Date in the past] Didn't schedule notification for Salah $salahName");
      return;
    }

    final AzanNotificationSetting setting = _azanSettingsStore.getNotificationSettingsForSalah(salah);

    if (setting == AzanNotificationSetting.nothing) {
      _logger.i("[$setting] Didn't schedule notification for Salah $salahName");
      return;
    }

    final int id = getIdForSalah(salah, salahDateTime);

    if (await isAzanScheduled(salah, salahDateTime)) {
      _logger.i('[ID:$id] Salah $salahName at $salahDateTime is already scheduled');
      return;
    }

    final AzanNotificationPayload payload = AzanNotificationPayload(
      id: id,
      salah: salah,
      dateTime: salahDateTime,
      setting: setting,
    );

    await _plugin.zonedSchedule(
      id,
      '$salahName Azan',
      'Time for ${salahName.toLowerCase()} salah',
      tz.TZDateTime.from(salahDateTime, tz.local),
      getNotificationDetails(setting),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: json.encode(payload.toJson()),
    );

    _logger.i('[ID:$id] Scheduled a notification for $salahName azan at $salahDateTime');

    if (updateCache) {
      updateScheduledAzansCache();
    }
  }

  Future<void> updateScheduledAzansToMatchSettings() async {
    await updateScheduledAzansCache();
    final List<AzanNotificationPayload> _azansToUpdate = [];
    for (final payload in _scheduledAzansCache.values) {
      final salah = payload.salah;
      final foundSettings = payload.setting;
      final expectedSettings = _azanSettingsStore.getNotificationSettingsForSalah(salah);

      if (foundSettings != expectedSettings) {
        await _plugin.cancel(getIdForSalah(salah, payload.dateTime));
        _azansToUpdate.add(payload);
      }
    }

    if (_azansToUpdate.isEmpty) {
      // nothing to update
      return;
    }

    //update cache to remove all outdated azans
    await updateScheduledAzansCache();

    for (final payload in _azansToUpdate) {
      await scheduleAzan(payload.salah, payload.dateTime);
    }
  }

  NotificationDetails getNotificationDetails(AzanNotificationSetting setting) {
    const String channelId = 'azan';
    const String channelName = 'Azan Notifications';
    const String channelDescription = 'MCND Azan Notifications';
    const priority = Priority.high;

    String? soundFile;
    if (setting == AzanNotificationSetting.short) {
      soundFile = 'short_azan';
    } else if (setting == AzanNotificationSetting.full) {
      soundFile = 'full_azan';
    }

    final android = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      priority: priority,
      sound: RawResourceAndroidNotificationSound(soundFile),
    );

    final ios = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: '$soundFile.aiff',
    );

    return NotificationDetails(
      android: android,
      iOS: ios,
    );
  }

  Future<bool> isAzanScheduled(Salah salah, DateTime salahDateTime, {bool forceUpdate = false}) async {
    if (_scheduledAzansCache.isEmpty || forceUpdate) {
      await updateScheduledAzansCache();
    }

    return _scheduledAzansCache.containsKey(getIdForSalah(salah, salahDateTime));
  }

  int getIdForSalah(Salah salah, DateTime salahDateTime) {
    final String datePart = notificationIdDatePartFormat.format(salahDateTime);
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
