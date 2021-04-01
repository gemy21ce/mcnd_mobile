import 'dart:async';

import 'package:hijri/hijri_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';

@injectable
class PrayerTimesViewModel extends StateNotifier<PrayerTimesModel> {
  final McndApi _api;
  final Mapper _mapper;

  final _timeFormat = DateFormat("H:mm a");
  final _dateFormat = DateFormat("MMMM dd, yyyy");
  final _hijriDatePattern = "dd MMMM yyyy";
  final _tickerDuration = Duration(seconds: 1);

  DateTime _dateNow = DateTime.now();
  Timer? _ticker;
  PrayerTime? _prayerTime;

  PrayerTimesViewModel(this._api, this._mapper)
      : super(PrayerTimesModel.loading());

  void fetchTimes() async {
    state = PrayerTimesModel.loading();
    try {
      final apiModel = (await _api.getPrayerTime(PrayerTimeFilter.TODAY)).first;
      _prayerTime = _mapper.mapApiPrayerTime(apiModel);
      state = PrayerTimesModel.loaded(_toModelData());
    } catch (e) {
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
    PrayerTime _prayerTime = this._prayerTime!;
    final dateString = _dateNow.format(_dateFormat);
    final hijriDateString =
        HijriCalendar.fromDate(_dateNow).toFormat(_hijriDatePattern);

    final upcommingSalah = _nearestSalah(_prayerTime, _dateNow);
    final upcommingSalahString =
        "${upcommingSalah.getStringName().toUpperCase()} IQAMAH";

    final upcommingSalahTime = _prayerTime.times[upcommingSalah]!;
    final timeToUpcommingSalah =
        getDateDiffrences(_dateNow, upcommingSalahTime.iqamah);

    final items = _prayerTime.times.entries.map((e) {
      final salah = e.key;
      final time = e.value;
      final highlight = salah == upcommingSalah;
      return PrayerTimesModelItem(
        prayerName: salah.getStringName(),
        begins: time.azan.format(_timeFormat),
        iqamah: time.iqamah.format(_timeFormat),
        highlight: highlight,
      );
    }).toList();

    items.insert(
      1,
      PrayerTimesModelItem(
        prayerName: "Sunrise",
        begins: _prayerTime.sunrise.format(_timeFormat),
        iqamah: "-",
      ),
    );

    return PrayerTimesModelData(
      date: dateString,
      hijriDate: hijriDateString,
      upcommingSalah: upcommingSalahString,
      timeToUpcommingSalah: timeToUpcommingSalah,
      times: items,
    );
  }

  Salah _nearestSalah(PrayerTime prayerTime, DateTime forTime) {
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

  String getDateDiffrences(DateTime currentDate, DateTime salahTime) {
    //fix salah time and add date from current date
    salahTime = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      salahTime.hour,
      salahTime.minute,
      salahTime.second,
    );

    final diff = currentDate.difference(salahTime).inSeconds.abs();
    final diffSecs = (diff % 60).round();
    final diffMinutes = ((diff / 60) % 60).round();
    final diffHours = (diff / (60 * 60)).round();
    String out = "";
    if (diffHours > 0) {
      out += "$diffHours hours ";
    }

    if (diffMinutes > 0) {
      out += "$diffMinutes minutes ";
    }

    if (diffSecs > 0) {
      out += "$diffSecs seconds ";
    }

    if (out.length > 1) {
      out = out.substring(0, out.length - 1);
    }

    return out;
  }
}
