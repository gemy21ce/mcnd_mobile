import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:dio/dio.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

@lazySingleton
class McndApi {
  final Dio _dio;
  final Mapper _mapper;

  McndApi(this._dio, this._mapper);

  Future<List<ApiPrayerTime>> getPrayerTime(PrayerTimeFilter filter) async {
    final response = await _dio.get(
      "prayertime",
      queryParameters: {
        "filter": filter.getApiStringValue(),
      },
    );

    final data = response.data;

    if (filter == PrayerTimeFilter.TODAY) {
      return _mapper.mapJsonList(
        data,
        (json) => ApiPrayerTime.fromJson(json),
      );
    }

    final List<List<ApiPrayerTime>> list = _mapper.mapJsonList(
      data,
      (json) => _mapper.mapJsonList(
        json,
        (json) => ApiPrayerTime.fromJson(json),
      ),
    );
    return list.first;
  }
}
