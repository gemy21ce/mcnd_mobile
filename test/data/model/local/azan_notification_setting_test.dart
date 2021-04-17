import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/local/azan_notification_setting.dart';

void main() {
  test('getId is consistent with fromId', () {
    const values = AzanNotificationSetting.values;

    final ids = values.map((e) => e.getId()).toList();

    final fromIds = ids.map((e) => AzanNotificationSettingExt.fromId(e));

    expect(fromIds, equals(values));
  });

  test('getId will result in no duplicates', () {
    const values = AzanNotificationSetting.values;

    final ids = values.map((e) => e.getId()).toList();

    final noDuplicates = Set.of(ids).toList();

    expect(ids.length, equals(noDuplicates.length));
  });
}
