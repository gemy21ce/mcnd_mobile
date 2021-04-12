import 'package:flutter/material.dart';

extension SeparatedWidgetList on List<Widget> {
  /// Make a list that have a separator widget between each 2 constrictive elements in the list
  List<Widget> separatedBy(Widget Function() separatorBuilder) {
    final List<Widget> items = [];
    for (var i = 0; i < length; i++) {
      items.add(this[i]);
      if (i < length - 1) {
        items.add(separatorBuilder());
      }
    }
    return items;
  }

  List<Widget> separatedByDivider() => separatedBy(() => const Divider());
}
