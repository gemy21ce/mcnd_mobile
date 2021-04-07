import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_page.dart';

@immutable
class _HomeScreenDrawerItems {
  final String title;
  final IconData icon;

  const _HomeScreenDrawerItems(this.title, this.icon);
}

const _drawerItems = [
  _HomeScreenDrawerItems('Home', Icons.home),
  _HomeScreenDrawerItems('Mosque Project', Icons.info),
  _HomeScreenDrawerItems('Donate', Icons.monetization_on),
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: Colors.black,
            ),
        centerTitle: true,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        elevation: 8,
        backgroundColor: Colors.white,
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
        items: const <BottomNavigationBarItem>[
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
                    onTap: () {},
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
