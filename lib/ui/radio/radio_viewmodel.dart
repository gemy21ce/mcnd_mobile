import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:injectable/injectable.dart';

@injectable
class RadioViewModel {
  final FlutterSoundPlayer _soundPlayer;

  RadioViewModel(this._soundPlayer);

  Future<void> load() async {}
}
