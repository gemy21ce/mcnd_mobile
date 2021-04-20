import 'package:flutter/material.dart';
import 'package:mcnd_mobile/ui/mcnd_router.gr.dart';

class McndApp extends StatelessWidget {
  final _router = McndRouter();

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.light();
    final theme = baseTheme.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: baseTheme.iconTheme.copyWith(
          color: Colors.black,
        ),
        textTheme: baseTheme.textTheme.apply(
          displayColor: Colors.black,
        ),
        elevation: 8,
        backgroundColor: Colors.white,
      ),
    );

    return MaterialApp.router(
      title: 'MCND Mosque',
      theme: theme,
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }
}
