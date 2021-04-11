import 'package:meta/meta.dart';

@immutable
class SalahTime {
  final DateTime azan;
  final DateTime? iqamah;

  const SalahTime(this.azan, [this.iqamah]);
}
