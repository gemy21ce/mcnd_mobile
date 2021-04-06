mixin MapperList {
  List<T> mapList<T>(
    dynamic originalList,
    T Function(dynamic json) listMapper,
  ) {
    return (originalList as List<dynamic>).map((dynamic e) => listMapper(e)).toList();
  }
}
