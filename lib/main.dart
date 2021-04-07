import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';
import 'package:mcnd_mobile/ui/mcnd_app.dart';

import 'di/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final injector = Injector.getInstance(); //initialize dependencies
  injector.get<LocalNotificationsService>().initialize();
  runApp(ProviderScope(child: McndApp()));
}
