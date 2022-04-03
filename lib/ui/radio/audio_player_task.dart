import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

const _radioUrl = 'http://stream.radiojar.com/htnudfgugm8uv';
const _mediaItem = MediaItem(
  id: 'quran_radio',
  title: 'Quran Radio Station',
  album: 'Quran',
);

Future<void> audioPlayerTaskEntrypoint() => AudioServiceBackground.run(() => AudioPlayerTask());

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _player = AudioPlayer();
  AudioProcessingState? _skipState;
  late StreamSubscription<PlaybackEvent> _eventSubscription;

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    debugPrint('AudioPlayerTask: onStart');
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _eventSubscription = _player.playbackEventStream.listen((event) {
      _broadcastState();
    });

    // Load and broadcast the queue
    AudioServiceBackground.setMediaItem(_mediaItem);
    try {
      await _player.setUrl(_radioUrl);
    } catch (e, stk) {
      debugPrintStack(label: e.toString(), stackTrace: stk);
      onStop();
    }
  }

  @override
  Future<void> onPlay() {
    debugPrint('AudioPlayerTask: onPlay');
    return _player.play();
  }

  @override
  Future<void> onPause() {
    debugPrint('AudioPlayerTask: onPause');
    return _player.pause();
  }

  @override
  Future<void> onStop() async {
    debugPrint('AudioPlayerTask: onStop');
    await _player.dispose();
    _eventSubscription.cancel();
    // It is important to wait for this state to be broadcast before we shut
    // down the task. If we don't, the background task will be destroyed before
    // the message gets sent to the UI.
    await _broadcastState();
    // Shut down this task
    await super.onStop();
  }

  /// Broadcasts the current state to all clients.
  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
      ],
      processingState: _getProcessingState(),
      playing: _player.playing,
    );
  }

  /// Maps just_audio's processing state into into audio_service's playing
  /// state. If we are in the middle of a skip, we use [_skipState] instead.
  AudioProcessingState _getProcessingState() {
    debugPrint('AudioPlayerTask: ${_player.processingState}');
    if (_skipState != null) return _skipState!;
    switch (_player.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception('Invalid state: ${_player.processingState}');
    }
  }
}
