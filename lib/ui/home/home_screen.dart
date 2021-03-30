import 'package:flutter/material.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MCND Mosque"),
      ),
      body: PrayerTimesPage(),
    );
  }
}
