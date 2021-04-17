import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:meta/meta.dart';

@immutable
class DayPrayers {
  final DateTime date;
  final Map<Salah, SalahTime> times;

  const DayPrayers(this.date, this.times);
}
