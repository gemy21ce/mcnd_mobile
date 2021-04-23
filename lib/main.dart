import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';
import 'package:mcnd_mobile/ui/mcnd_app.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'di/injector.dart';

Future<void> main() async {
  await _initialize();
  runApp(ProviderScope(child: McndApp()));
}

Future<void> _initialize() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  //insure flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await initializeInjector();

  final LocalNotificationsService localNotificationsService = injector.get();
  await localNotificationsService.initialize();

  //timezone initialization required for FlutterLocalNotificationsPlugin
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
