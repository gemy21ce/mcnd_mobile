import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

extension MapperList on Mapper {
  List<T> mapList<T>(
    dynamic originalList,
    T Function(dynamic json) listMapper,
  ) {
    return (originalList as List<dynamic>).map((e) => listMapper(e)).toList();
  }
}
