import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/app/salah.dart';

void main() {
  test('getId is consistent with fromId', () {
    const values = Salah.values;

    final ids = values.map((e) => e.getId()).toList();

    final fromIds = ids.map((e) => SalahExt.fromId(e));

    expect(fromIds, equals(values));
  });

  test('getId will result in no duplicates', () {
    const values = Salah.values;

    final ids = values.map((e) => e.getId()).toList();

    final noDuplicates = Set.of(ids).toList();

    expect(ids.length, equals(noDuplicates.length));
  });
}
