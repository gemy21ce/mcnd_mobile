import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Quran Radio',
          maxLines: 1,
          maxFontSize: 30,
          minFontSize: 15,
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Egypt Quran Karim Station',
              textAlign: TextAlign.center,
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {},
              label: const Text('Play'),
            )
          ],
        ),
      ),
    );
  }
}
