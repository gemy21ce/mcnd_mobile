import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/mcnd_datetime_converter.dart';

void main() {
  test('McndDateConverter', () {
    const converter = McndDateConverter();
    const dateStr = '2011-09-20';
    final date = DateTime(2011, 9, 20);

    expect(converter.fromJson(dateStr), equals(date));
    expect(converter.toJson(date), equals(dateStr));
  });

  test('McndTimeConverter', () {
    const converter = McndTimeConverter();
    const timeStr = '13:09:20';
    final time = DateTime(1970, 1, 1, 13, 9, 20);

    expect(converter.fromJson(timeStr), equals(time));
    expect(converter.toJson(time), equals(timeStr));
  });

  test('McndDateTimeConverter', () {
    const converter = McndDateTimeConverter();
    const timeStr = '2055-03-04T13:09:20';
    final time = DateTime(2055, 3, 4, 13, 9, 20);

    expect(converter.fromJson(timeStr), equals(time));
    expect(converter.toJson(time), equals(timeStr));
  });
}
