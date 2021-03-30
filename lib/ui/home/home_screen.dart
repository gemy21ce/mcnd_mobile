import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MCND Mosque"),
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
    );
  }
}
