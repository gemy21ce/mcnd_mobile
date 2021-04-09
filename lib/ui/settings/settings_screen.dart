import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Settings',
          maxLines: 1,
          maxFontSize: 30,
          minFontSize: 15,
        ),
      ),
    );
  }
}
