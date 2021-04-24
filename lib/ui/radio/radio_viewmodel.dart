import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mcnd_mobile/ui/radio/radio_screen_model.dart';

@injectable
class RadioViewModel extends StateNotifier<RadioScreenModel> {
  final AudioPlayer _audioPlayer;

  StreamSubscription<PlayerState>? _streamSubscription;

  RadioViewModel(this._audioPlayer) : super(const RadioScreenModel.loading());

  void _onPlayerStateChanged(PlayerState playerState) {
    if (playerState.processingState == ProcessingState.loading) {
      state = const RadioScreenModel.loading();
      return;
    }
    state = playerState.playing ? const RadioScreenModel.playing() : const RadioScreenModel.stopped();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Future<void> load() async {
    _streamSubscription = _audioPlayer.playerStateStream.listen(_onPlayerStateChanged);
  }

  Future<void> play() async {
    state = const RadioScreenModel.loading();
    _audioPlayer.setUrl('http://stream.radiojar.com/htnudfgugm8uv').then((value) => _audioPlayer.play());
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }
}
