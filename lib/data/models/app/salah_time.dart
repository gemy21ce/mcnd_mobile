import 'package:freezed_annotation/freezed_annotation.dart';

part 'salah_time.freezed.dart';

@freezed
class SalahTime with _$SalahTime {
  factory SalahTime(DateTime azan, [DateTime? iqamah]) = _SalahTime;
}
