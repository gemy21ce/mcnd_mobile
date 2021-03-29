import 'package:flutter/material.dart';
import 'package:mcnd_mobile/ui/home/home_screen.dart';

class McndApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCND Mosque',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
