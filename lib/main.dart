import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';
import 'package:mcnd_mobile/ui/mcnd_app.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'di/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final injector = Injector.getInstance(); //initialize dependencies
  injector.get<LocalNotificationsService>().initialize();
  initializeTimeZone();
  runApp(ProviderScope(child: McndApp()));
}

Future<void> initializeTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
