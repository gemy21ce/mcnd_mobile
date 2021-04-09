import 'package:flutter/material.dart';
import 'package:mcnd_mobile/ui/mcnd_router.gr.dart';

class McndApp extends StatelessWidget {
  final _router = McndRouter();

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData.light();
    return MaterialApp.router(
      title: 'MCND Mosque',
      theme: lightTheme.copyWith(
          appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: lightTheme.iconTheme.copyWith(
          color: Colors.black,
        ),
        textTheme: lightTheme.textTheme.apply(
          displayColor: Colors.black,
        ),
        elevation: 8,
        backgroundColor: Colors.white,
      )),
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }
}
