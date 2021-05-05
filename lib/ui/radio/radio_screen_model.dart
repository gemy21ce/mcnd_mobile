import 'package:freezed_annotation/freezed_annotation.dart';

part 'radio_screen_model.freezed.dart';

@freezed
class RadioScreenModel with _$RadioScreenModel {
  const factory RadioScreenModel.loading() = Loading;
  const factory RadioScreenModel.stopped() = Stopped;
  const factory RadioScreenModel.playing() = Playing;
}
