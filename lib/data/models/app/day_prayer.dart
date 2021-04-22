import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';

part 'day_prayer.freezed.dart';

@freezed
class DayPrayers with _$DayPrayers {
  const factory DayPrayers(
    DateTime date,
    Map<Salah, SalahTime> times,
  ) = _DayPrayers;
}

extension DayPrayersListExt on List<DayPrayers> {
  DayPrayers findPrayersForDate(DateTime time) {
    return where((dayTimes) => dayTimes.date.isDateOnlyEquals(time)).first;
  }

  int findIndexForDate(DateTime time) {
    return indexOf(findPrayersForDate(time));
  }
}
