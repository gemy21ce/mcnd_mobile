import 'dart:async';

import 'package:hijri/hijri_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/core/utils/duration_utils.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/services/azan_times_service.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';
import 'package:meta/meta.dart';

@injectable
class PrayerTimesViewModel extends StateNotifier<PrayerTimesModel> {
  final AzanTimesService _azanTimesService;
  final Logger _logger;

  final _timeFormat = DateFormat('h:mm a');
  final _dateFormat = DateFormat('MMMM dd, yyyy');
  final _hijriDatePattern = 'dd MMMM yyyy';
  final _tickerDuration = const Duration(seconds: 30);

  DateTime _dateNow = DateTime.now();
  Timer? _ticker;
  DayPrayers? _prayerTime;

  PrayerTimesViewModel(this._azanTimesService, this._logger) : super(const PrayerTimesModel.loading());

  Future<void> fetchTimes() async {
    state = const PrayerTimesModel.loading();
    try {
      _prayerTime = await _azanTimesService.fetchPrayerTimeForTheDay();
      state = PrayerTimesModel.loaded(_toModelData());
    } catch (e, stk) {
      _logger.e('Failed to fetch prayer times', e, stk);
      state = PrayerTimesModel.error(e.toString());
    }
  }

  void startTicker() {
    _ticker = Timer.periodic(_tickerDuration, (_) {
      if (state is Loaded) {
        _dateNow = DateTime.now();
        state = PrayerTimesModel.loaded(_toModelData());
      } else {
        _prayerTime = null;
        stopTicker();
      }
    });
  }

  void stopTicker() {
    _ticker?.cancel();
  }

  PrayerTimesModelData _toModelData() {
    final DayPrayers _prayerTime = this._prayerTime!;
    final dateString = _dateNow.format(_dateFormat);
    final hijriDateString = HijriCalendar.fromDate(_dateNow).toFormat(_hijriDatePattern);

    final upcomingSalah = nearestSalah(_prayerTime, _dateNow);
    final upcomingSalahString = '${upcomingSalah.getStringName().toUpperCase()} IQAMAH';

    final upcomingSalahTime = _prayerTime.times[upcomingSalah]!;
    final upcomingDateTime = (upcomingSalah == Salah.sunrise) ? upcomingSalahTime.azan : upcomingSalahTime.iqamah!;
    final timeToUpcomingSalah = upcomingDateTime.difference(_dateNow).getTimeDifferenceString(
          seconds: false,
        );

    final items = _prayerTime.times.entries.map((e) {
      final salah = e.key;
      final time = e.value;
      final highlight = salah == upcomingSalah;
      return PrayerTimesModelItem(
        prayerName: salah.getStringName(),
        azan: time.azan.format(_timeFormat),
        iqamah: time.iqamah?.format(_timeFormat),
        highlight: highlight,
      );
    }).toList();

    return PrayerTimesModelData(
      date: dateString,
      hijriDate: hijriDateString,
      upcommingSalah: upcomingSalahString,
      timeToUpcommingSalah: timeToUpcomingSalah,
      times: items,
    );
  }

  @visibleForTesting
  Salah nearestSalah(DayPrayers prayerTime, DateTime forTime) {
    final times = prayerTime.times.entries.toList()
      ..sort((a, b) {
        return a.value.azan.compareTo(b.value.azan);
      });
    for (final t in times) {
      if (t.value.azan.isAfter(forTime)) {
        return t.key;
      }
    }
    return times.last.key;
  }
}
