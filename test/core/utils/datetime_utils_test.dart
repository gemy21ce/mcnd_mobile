import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';

void main() {
  test('DateTimeUtils format', () {
    final formatter = DateFormat.jms();
    final date = DateTime.now();

    expect(formatter.format(date), date.format(formatter));
  });

  test('DateTimeUtils matchDateWith', () {
    final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd', 'en-US');
    final DateFormat _timeFormatter = DateFormat('HH:mm:ss', 'en-US');
    final DateFormat _combinedFormatter = DateFormat(
      '${_dateFormatter.pattern!} ${_timeFormatter.pattern!}',
      'en-US',
    );

    final date = _dateFormatter.parse('2011-11-02');
    final time = _timeFormatter.parse('05:03:44');
    final combined = _combinedFormatter.parse('2011-11-02 05:03:44');

    final matchedDateTime = time.matchDateWith(date);

    expect(matchedDateTime, combined);
  });

  group('isDateOnlyEquals', () {
    test('will return false on different date', () {
      final d1 = DateTime(2014, 1, 5, 2, 2, 2);
      final d2 = DateTime(2014, 1, 4, 2, 2, 2);
      expect(d1.isDateOnlyEquals(d2), false);
    });

    test('will return true on same date different time', () {
      final d1 = DateTime(2014, 1, 5, 1, 2, 3);
      final d2 = DateTime(2014, 1, 5, 4, 5, 6);
      expect(d1.isDateOnlyEquals(d2), true);
    });
  });

  group('isDateOnlyAfter', () {
    final testCases = [
      [
        false,
        DateTime(2012, 11, 15, 10, 22, 33),
        DateTime(2012, 11, 15, 10, 22, 33),
      ],
      [
        false,
        DateTime(2012, 11, 15, 10, 22, 33),
        DateTime(2012, 11, 15, 22, 11, 44),
      ],
      [
        false,
        DateTime(2011, 11, 15, 10, 22, 33),
        DateTime(2012, 11, 15, 22, 11, 44),
      ],
      [
        false,
        DateTime(2012, 10, 15, 10, 22, 33),
        DateTime(2012, 11, 15, 22, 11, 44),
      ],
      [
        false,
        DateTime(2012, 11, 14, 10, 22, 33),
        DateTime(2012, 11, 15, 22, 11, 44),
      ],
      [
        false,
        DateTime(2011, 10, 14, 10, 22, 33),
        DateTime(2012, 11, 15, 22, 11, 44),
      ],
      [
        true,
        DateTime(2012, 11, 15, 22, 11, 44),
        DateTime(2011, 11, 15, 10, 22, 33),
      ],
      [
        true,
        DateTime(2012, 11, 15, 22, 11, 44),
        DateTime(2012, 10, 15, 10, 22, 33),
      ],
      [
        true,
        DateTime(2012, 11, 15, 22, 11, 44),
        DateTime(2012, 11, 14, 10, 22, 33),
      ],
      [
        true,
        DateTime(2012, 11, 15, 22, 11, 44),
        DateTime(2011, 10, 14, 10, 22, 33),
      ],
    ];

    for (var i = 0; i < testCases.length; i++) {
      final testCase = testCases[i];
      test('[$i]', () {
        final expectedResult = testCase[0] as bool;
        final d1 = testCase[1] as DateTime;
        final d2 = testCase[2] as DateTime;
        expect(d1.isDateOnlyAfter(d2), expectedResult);
      });
    }
  });
}
