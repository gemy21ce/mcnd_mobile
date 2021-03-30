import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/data/models/app/prayer_time.dart';
import 'package:mcnd_mobile/data/models/app/salah_time.dart';
import 'package:mcnd_mobile/data/models/app/salawat.dart';
import 'package:mcnd_mobile/ui/prayer_times/providers.dart';

class PrayerTimesWidget extends HookWidget {
  final PrayerTime prayerTime;

  const PrayerTimesWidget(this.prayerTime, {Key? key}) : super(key: key);

  Salah nearestSalah(DateTime forTime) {
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

  @override
  Widget build(BuildContext context) {
    final dateString = useProvider(currentDateStringProvider);
    final hijriDateString = useProvider(currentHigriDateStringProvider);
    final timeFormatter = useProvider(timeFormatterProvider);
    final currentDate = useProvider(currentDateProvider);
    final salah = nearestSalah(currentDate);
    final salahTime = prayerTime.times[salah]!;

    return ListView(
      children: [
        Text(dateString),
        Text(hijriDateString),
        Text("${salah.getStringName().toUpperCase()} IQAMAH"),
        Text(timeFormatter.format(salahTime.iqamah)),
        Text(timeFormatter.format(currentDate)),
        Text(getDateDiffrences(currentDate, salahTime.iqamah)),
      ],
    );
  }
}
