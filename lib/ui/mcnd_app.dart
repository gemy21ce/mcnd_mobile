import 'package:flutter/material.dart';
import 'package:mcnd_mobile/ui/mcnd_router.gr.dart';

class McndApp extends StatelessWidget {
  final _router = McndRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MCND Mosque',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }
}
