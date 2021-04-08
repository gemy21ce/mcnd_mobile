import 'dart:async';

import 'package:hijri/hijri_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/core/utils/duration_utils.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';
import 'package:mcnd_mobile/services/local_notifications_service.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';
import 'package:meta/meta.dart';

@injectable
class PrayerTimesViewModel extends StateNotifier<PrayerTimesModel> {
  final McndApi _api;
  final Mapper _mapper;
  final LocalNotificationsService _localNotificationsService;

  final _timeFormat = DateFormat('h:mm a');
  final _dateFormat = DateFormat('MMMM dd, yyyy');
  final _hijriDatePattern = 'dd MMMM yyyy';
  final _tickerDuration = const Duration(seconds: 30);

  DateTime _dateNow = DateTime.now();
  Timer? _ticker;
  PrayerTime? _prayerTime;

  PrayerTimesViewModel(this._api, this._mapper, this._localNotificationsService)
      : super(const PrayerTimesModel.loading());

  Future<void> fetchTimes() async {
    state = const PrayerTimesModel.loading();
    try {
      final apiModel = (await _api.getPrayerTime(PrayerTimeFilter.today)).first;
      _prayerTime = _mapper.mapApiPrayerTime(apiModel);
      _scheduleNotifications();
      state = PrayerTimesModel.loaded(_toModelData());
    } catch (e) {
      state = PrayerTimesModel.error(e.toString());
    }
  }

  Future<void> _scheduleNotifications() async {
    final PrayerTime _prayerTime = this._prayerTime!;
    final futures = _prayerTime.times.entries.map((e) {
      final Salah salah = e.key;
      final SalahTime salahTime = e.value;

      if (salahTime.azan.isBefore(DateTime.now())) {
        return Future.value(null);
      }

      return _localNotificationsService.scheduleAzan(salah, salahTime);
    });
    await Future.wait(futures);
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
    final PrayerTime _prayerTime = this._prayerTime!;
    final dateString = _dateNow.format(_dateFormat);
    final hijriDateString = HijriCalendar.fromDate(_dateNow).toFormat(_hijriDatePattern);

    final upcomingSalah = nearestSalah(_prayerTime, _dateNow);
    final upcomingSalahString = '${upcomingSalah.getStringName().toUpperCase()} IQAMAH';

    final upcomingSalahTime = _prayerTime.times[upcomingSalah]!;
    final timeToUpcomingSalah = upcomingSalahTime.iqamah.difference(_dateNow).getTimeDifferenceString(
          seconds: false,
        );

    final items = _prayerTime.times.entries.map((e) {
      final salah = e.key;
      final time = e.value;
      final highlight = salah == upcomingSalah;
      return PrayerTimesModelItem(
        prayerName: salah.getStringName(),
        azan: time.azan.format(_timeFormat),
        iqamah: time.iqamah.format(_timeFormat),
        highlight: highlight,
      );
    }).toList();

    items.insert(
      1,
      PrayerTimesModelItem(
        prayerName: 'Sunrise',
        azan: _prayerTime.sunrise.format(_timeFormat),
      ),
    );

    return PrayerTimesModelData(
      date: dateString,
      hijriDate: hijriDateString,
      upcommingSalah: upcomingSalahString,
      timeToUpcommingSalah: timeToUpcomingSalah,
      times: items,
    );
  }

  @visibleForTesting
  Salah nearestSalah(PrayerTime prayerTime, DateTime forTime) {
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
