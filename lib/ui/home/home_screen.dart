import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mcnd_mobile/gen/assets.gen.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_page.dart';

@immutable
class _HomeScreenDrawerItems {
  final String title;
  final IconData icon;

  const _HomeScreenDrawerItems(this.title, this.icon);
}

const _drawerItems = [
  _HomeScreenDrawerItems("Home", Icons.home),
  _HomeScreenDrawerItems("Mosque Project", Icons.info),
  _HomeScreenDrawerItems("Donate", Icons.monetization_on),
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: Colors.black,
              fontSizeFactor: 1,
            ),
        centerTitle: true,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        elevation: 8,
        backgroundColor: Colors.white,
        title: Text("Muslim Community North Dublin"),
      ),
      body: PrayerTimesPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.clockOutline),
            label: "Prayer Times",
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.compass),
            label: "Compass",
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.newspaper),
            label: "News",
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              ..._drawerItems.map((e) => InkWell(
                    child: ListTile(
                      title: Text(e.title),
                      leading: Icon(e.icon),
                    ),
                    onTap: () {},
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
