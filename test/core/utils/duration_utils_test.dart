import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mcnd_mobile/core/utils/duration_utils.dart';

final DateFormat _dateFormatter = DateFormat('yy-MM-dd', 'en-US');
final DateFormat _timeFormatter = DateFormat('HH:mm:ss', 'en-US');
final DateFormat _combinedFormatter = DateFormat(
  '${_dateFormatter.pattern!} ${_timeFormatter.pattern!}',
  'en-US',
);

Duration _getDiff(String ds1, String ds2) {
  final d1 = _combinedFormatter.parse(ds1);
  final d2 = _combinedFormatter.parse(ds2);
  final diff = d1.difference(d2);
  return diff;
}

void main() {
  group('DurationUtils.getTimeDifferenceString', () {
    final inputs = [
      [
        '11-11-11 11:11:11',
        '11-11-11 12:11:11',
        '1 hours',
      ],
      [
        '11-11-11 11:11:11',
        '11-11-11 12:11:10',
        '59 minutes 59 seconds',
      ],
      [
        '11-11-11 2:3:55',
        '11-11-11 13:6:22',
        '11 hours 2 minutes 27 seconds',
      ],
      [
        '11-11-11 22:11:55',
        '11-11-12 21:10:33',
        '22 hours 58 minutes 38 seconds',
      ],
      [
        '11-11-12 21:10:33',
        '11-11-11 22:11:55',
        '22 hours 58 minutes 38 seconds',
      ],
    ];

    for (final input in inputs) {
      test('([${input[0]}] - [${input[1]}]) ==> ${input[2]}', () {
        expect(
          _getDiff(input[0], input[1]).getTimeDifferenceString(),
          input[2],
        );
      });
    }

    test('will show only given params', () {
      const d1 = '11-11-12 21:10:33';
      const d2 = '11-11-11 22:11:55';
      final diff = _getDiff(d1, d2);

      const h = '22 hours';
      const m = '58 minutes';
      const s = '38 seconds';

      expect(
        diff.getTimeDifferenceString(),
        '$h $m $s',
      );

      expect(
        diff.getTimeDifferenceString(
          seconds: false,
        ),
        '$h $m',
      );

      expect(
        diff.getTimeDifferenceString(
          seconds: false,
          minutes: false,
        ),
        h,
      );
    });
  });
}
