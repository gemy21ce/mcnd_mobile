import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/api_featured_media.dart';
import 'package:mcnd_mobile/data/models/api/api_news_post.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';

@lazySingleton
class McndApi {
  final Dio _dio;

  McndApi(this._dio);

  Future<List<ApiPrayerTime>> getPrayerTime(PrayerTimeFilter filter) async {
    final response = await _dio.get<dynamic>(
      'dpt/v1/prayertime',
      queryParameters: <String, String>{
        'filter': filter.getApiStringValue(),
      },
    );

    return (((filter == PrayerTimeFilter.today) ? response.data! : response.data!.first) as List)
        .map((dynamic e) => ApiPrayerTime.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ApiNewsPost>> getNewsPosts() async {
    final response = await _dio.get<dynamic>('wp/v2/posts');
    return (response.data as List).map((dynamic e) => ApiNewsPost.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<ApiFeaturedMedia> getFeaturedMedia(int id) async {
    final response = await _dio.get<dynamic>('wp/v2/media/$id');
    return ApiFeaturedMedia.fromJson(response.data as Map<String, dynamic>);
  }
}
