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

    final iosInit = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: false,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _plugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );

    await _plugin.initialize(initializationSettings);

    _initialized = true;
  }

  Future _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {}

  Future _onSelectNotification(String? payload) async {}
}
