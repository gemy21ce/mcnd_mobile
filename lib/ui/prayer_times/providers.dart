import 'package:hijri/hijri_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final _timeFormat = DateFormat("H:mm a");
final _dateFormat = DateFormat("MMMM dd, yyyy");

final timeFormatterProvider = Provider<DateFormat>((ref) {
  return _timeFormat;
});

final currentDateStringProvider = Provider<String>((ref) {
  final date = ref.read(currentDateProvider);
  return _dateFormat.format(date);
});

final currentHigriDateStringProvider = Provider<String>((ref) {
  final date = ref.read(currentDateProvider);
  return HijriCalendar.fromDate(date).toFormat("dd MMMM yyyy");
});

final currentDateProvider = Provider<DateTime>((ref) {
  return ref.watch(tickerProvider).data?.value ?? DateTime.now();
});

final tickerProvider = StreamProvider<DateTime>((ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(Duration(seconds: 1), (timer) {
    return DateTime.now();
  });
});
