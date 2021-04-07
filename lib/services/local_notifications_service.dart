import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;

@lazySingleton
class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _plugin;

  LocalNotificationsService(this._plugin);

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

  Future<void> scheduleAzan({
    required String name,
    required DateTime dateTime,
  }) async {
    final int id = Random().nextInt(1024 * 1024);
    await _plugin.zonedSchedule(
      id,
      name,
      '',
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
    );
  }
}
