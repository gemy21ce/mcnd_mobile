import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _plugin;

  LocalNotificationsService(this._plugin);

  bool _initialized = false;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('app_icon');

    const iosInit = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

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
}
