extension SpratedList<T> on List<T> {
  List<T> separatedBy(T Function() separatorBuilder) {
    final List<T> items = [];
    for (var i = 0; i < length; i++) {
      items.add(this[i]);
      if (i < length - 1) {
        items.add(separatorBuilder());
      }
    }
    return items;
  }
}
