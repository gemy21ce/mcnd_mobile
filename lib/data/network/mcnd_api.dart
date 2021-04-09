import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';

@lazySingleton
class McndApi {
  final Dio _dio;

  McndApi(this._dio);

  Future<List<ApiPrayerTime>> getPrayerTime(PrayerTimeFilter filter) async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      'prayertime',
      queryParameters: <String, String>{
        'filter': filter.getApiStringValue(),
      },
    );

    return (((filter == PrayerTimeFilter.today) ? response.data! : response.data!.first) as List)
        .map((dynamic e) => ApiPrayerTime.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
