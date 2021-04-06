import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

main() {
  test('mapList', () {
    final original = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    final squared = [
      1 * 1,
      2 * 2,
      3 * 3,
      4 * 4,
      5 * 5,
      6 * 6,
      7 * 7,
      8 * 8,
      9 * 9,
      10 * 10,
    ];

    final mapper = Mapper();
    final result = mapper.mapList(original, (e) => e * e);

    expect(result, squared);
  });
}
