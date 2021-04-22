import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:meta/meta.dart';

@immutable
class DayPrayers {
  final DateTime date;
  final Map<Salah, SalahTime> times;

  const DayPrayers(this.date, this.times);
}

extension DayPrayersListExt on List<DayPrayers> {
  DayPrayers findPrayersForDate(DateTime time) {
    return where((dayTimes) => dayTimes.date.isDateOnlyEquals(time)).first;
  }

  int findIndexForDate(DateTime time) {
    return indexOf(findPrayersForDate(time));
  }
}
