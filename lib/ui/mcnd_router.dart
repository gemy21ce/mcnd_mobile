import 'package:auto_route/annotations.dart';
import 'package:mcnd_mobile/ui/home/home_screen.dart';
import 'package:mcnd_mobile/ui/radio/radio_screen.dart';
import 'package:mcnd_mobile/ui/settings/settings_screen.dart';

import 'news_post_details/news_post_details_screen.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute<void>(page: HomeScreen, initial: true),
    AutoRoute<void>(page: SettingsScreen),
    AutoRoute<void>(page: NewsPostDetailsScreen),
    AutoRoute<void>(page: RadioScreen),
  ],
)
class $McndRouter {}
