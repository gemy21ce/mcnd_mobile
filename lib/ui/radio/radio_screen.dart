import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/providers.dart';
import 'package:mcnd_mobile/ui/shared/hooks/use_once.dart';
import 'package:mcnd_mobile/gen/assets.gen.dart';

class RadioScreen extends HookWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(radioViewModelProvider);
    final state = useProvider(radioViewModelProvider.state);
    useOnce(() => viewModel.load());
    final Size screenSize = MediaQuery.of(context).size;
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
            Assets.images.radio.image(width: screenSize.width * .8),
            SizedBox(height: screenSize.height * .05),
            const Text(
              'Quran Karim Radio',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenSize.height * .1),
            state.when(
              stopped: () => OutlinedButton.icon(
                icon: const Icon(Icons.play_arrow),
                onPressed: () => viewModel.play(),
                label: const Text('Play'),
              ),
              playing: () => OutlinedButton.icon(
                icon: const Icon(Icons.stop),
                onPressed: () => viewModel.stop(),
                label: const Text('Stop'),
              ),
              loading: () => OutlinedButton.icon(
                icon: const CircularProgressIndicator(),
                label: const Text('Loading'),
                onPressed: null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
