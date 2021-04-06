import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

@lazySingleton
class McndApi {
  final Dio _dio;
  final Mapper _mapper;

  McndApi(this._dio, this._mapper);

  Future<List<ApiPrayerTime>> getPrayerTime(PrayerTimeFilter filter) async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      'prayertime',
      queryParameters: <String, String>{
        'filter': filter.getApiStringValue(),
      },
    );

    final dynamic data = response.data;

    if (filter == PrayerTimeFilter.today) {
      return _mapper.mapList(
        data,
        (dynamic json) => ApiPrayerTime.fromJson(json as Map<String, dynamic>),
      );
    }

    final List<List<ApiPrayerTime>> list = _mapper.mapList(
      data,
      (dynamic json) => _mapper.mapList(
        json,
        (dynamic json) => ApiPrayerTime.fromJson(json as Map<String, dynamic>),
      ),
    );
    return list.first;
  }
}
