import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';

main() {
  test('DateTimeUtils format', () {
    final formatter = DateFormat.jms();
    final date = DateTime.now();

    expect(formatter.format(date), date.format(formatter));
  });

  test('DateTimeUtils matchDateWith', () {
    final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd', 'en-US');
    final DateFormat _timeFormatter = DateFormat('HH:mm:ss', 'en-US');
    final DateFormat _combinedFormatter = DateFormat(
      _dateFormatter.pattern! + ' ' + _timeFormatter.pattern!,
      'en-US',
    );

    final date = _dateFormatter.parse('2011-11-02');
    final time = _timeFormatter.parse('05:03:44');
    final combined = _combinedFormatter.parse('2011-11-02 05:03:44');

    final matchedDateTime = time.matchDateWith(date);

    expect(matchedDateTime, combined);
  });
}
