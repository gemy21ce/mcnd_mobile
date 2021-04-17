extension IndexedIterable<E> on Iterable<E> {
  /// mapIndexed is the same as map but with index passed in as a parameter
  Iterable<T> mapIndexed<T>(T Function(int i, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}
