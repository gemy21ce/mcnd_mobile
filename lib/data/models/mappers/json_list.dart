import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

extension MapperJsonList on Mapper {
  List<T> mapJsonList<T>(
    dynamic jsonList,
    T Function(dynamic json) mapper,
  ) {
    return (jsonList as List<dynamic>).map((e) => mapper(e)).toList();
  }
}
