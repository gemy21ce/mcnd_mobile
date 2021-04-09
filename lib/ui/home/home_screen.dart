import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mcnd_mobile/ui/mcnd_router.gr.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_page.dart';

@immutable
class _HomeScreenDrawerItems {
  final String title;
  final IconData icon;
  final PageRouteInfo<void>? route;

  const _HomeScreenDrawerItems(this.title, this.icon, {this.route});
}

const _drawerItems = [
  _HomeScreenDrawerItems('Home', Icons.home),
  _HomeScreenDrawerItems('Mosque Project', Icons.info),
  _HomeScreenDrawerItems('Donate', Icons.monetization_on),
  _HomeScreenDrawerItems('Settings', Icons.settings, route: SettingsScreenRoute()),
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Muslim Community North Dublin',
          maxLines: 1,
          maxFontSize: 30,
          minFontSize: 15,
        ),
      ),
      body: const PrayerTimesPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.clockOutline),
            label: 'Prayer Times',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.compass),
            label: 'Compass',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.newspaper),
            label: 'News',
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              ..._drawerItems.map((e) => InkWell(
                    onTap: () {
                      if (e.route != null) {
                        AutoRouter.of(context).pop(); // close the drawer
                        AutoRouter.of(context).push(e.route!);
                      }
                    },
                    child: ListTile(
                      title: Text(e.title),
                      leading: Icon(e.icon),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
