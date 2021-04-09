import 'package:auto_route/annotations.dart';
import 'package:mcnd_mobile/ui/home/home_screen.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute<void>(page: HomeScreen, initial: true),
  ],
)
class $McndRouter {}
