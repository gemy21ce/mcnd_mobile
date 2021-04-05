import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/ui/mcnd_app.dart';

import 'di/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.getInstance(); //initlize dependencies
  runApp(ProviderScope(child: McndApp()));
}
