import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mcnd_mobile/ui/mcnd_router.gr.dart';
import 'package:mcnd_mobile/ui/news/news_page.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_page.dart';

@immutable
class _HomeScreenDrawerItems {
  final String title;
  final IconData icon;
  final String? routePath;

  const _HomeScreenDrawerItems(this.title, this.icon, {this.routePath});
}

final _drawerItems = [
  const _HomeScreenDrawerItems('Home', Icons.home),
  const _HomeScreenDrawerItems('Mosque Project', Icons.info),
  const _HomeScreenDrawerItems('Donate', Icons.monetization_on),
  _HomeScreenDrawerItems('Azan Settings', Icons.settings, routePath: const SettingsScreenRoute().path),
];

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final currentPage = useState(0);
    final pageController = usePageController(initialPage: currentPage.value);
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Muslim Community North Dublin',
          maxLines: 1,
          maxFontSize: 30,
          minFontSize: 15,
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          currentPage.value = value;
        },
        children: const [
          PrayerTimesPage(),
          Center(
            child: Text('Compass'),
          ),
          NewsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage.value,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
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
                      if (e.routePath != null) {
                        AutoRouter.of(context).pop(); // close the drawer
                        AutoRouter.of(context).pushPath(e.routePath!);
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
