import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:mcnd_mobile/data/models/app/salawat.dart';
import 'package:meta/meta.dart';

@immutable
class PrayerTime {
  final DateTime date;
  final Map<Salah, SalahTime> times;
  final DateTime sunrise;

  PrayerTime(this.date, this.times, this.sunrise);
}
