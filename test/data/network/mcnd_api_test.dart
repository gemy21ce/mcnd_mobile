import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/api/api_featured_media.dart';
import 'package:mcnd_mobile/data/models/api/api_news_post.dart';
import 'package:mcnd_mobile/data/models/api/api_prayer_time.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../_test_shared/api_response.dart';
import 'mcnd_api_test.mocks.dart';

extension _WhenDio on MockDio {
  PostExpectation<Future<Response<dynamic>>> whenAnyGet() {
    final res = when(get<dynamic>(
      any,
      queryParameters: anyNamed('queryParameters'),
      options: anyNamed('options'),
      cancelToken: anyNamed('cancelToken'),
      onReceiveProgress: anyNamed('onReceiveProgress'),
    ));

    return res;
  }
}

@GenerateMocks([Mapper, Dio])
void main() {
  group('getPrayerTime', () {
    test('when McndApi called with TODAY filter it adds it to the arguments and receives correct result', () async {
      final dio = MockDio();
      final api = McndApi(dio);

      final expectedResponseJson = [apiPrayerDayResponse];
      final expectedResponseParsed =
          expectedResponseJson.map((dynamic json) => ApiPrayerTime.fromJson(json as Map<String, dynamic>));

      dio.whenAnyGet().thenAnswer((_) => Future.value(Response<dynamic>(
            data: expectedResponseJson,
            requestOptions: RequestOptions(path: ''),
          )));

      final result = await api.getPrayerTime(PrayerTimeFilter.today);

      expect(result, expectedResponseParsed);

      verify(dio.get<dynamic>(
        any,
        queryParameters: argThat(
          equals({'filter': 'today'}),
          named: 'queryParameters',
        ),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      ));
    });

    test(
        'when McndApi called with (MONTH, YEAR) filter it adds it to the arguments and receives correct result (unwrapped)',
        () async {
      final dio = MockDio();
      final api = McndApi(dio);

      final expectedResponseJson = [
        [
          apiPrayerDayResponse,
          apiPrayerDayResponse,
          apiPrayerDayResponse,
          apiPrayerDayResponse,
          apiPrayerDayResponse,
        ]
      ];
      final expectedResponseParsed = expectedResponseJson.first.map(
        (dynamic json) => ApiPrayerTime.fromJson(json as Map<String, dynamic>),
      );

      dio.whenAnyGet().thenAnswer((_) => Future.value(Response<dynamic>(
            data: expectedResponseJson,
            requestOptions: RequestOptions(path: ''),
          )));

      final resultMonth = await api.getPrayerTime(PrayerTimeFilter.month);
      expect(resultMonth, expectedResponseParsed);

      final resultYear = await api.getPrayerTime(PrayerTimeFilter.year);
      expect(resultYear, expectedResponseParsed);

      verify(dio.get<dynamic>(
        any,
        queryParameters: argThat(
          equals({'filter': 'month'}),
          named: 'queryParameters',
        ),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      ));

      verify(dio.get<dynamic>(
        any,
        queryParameters: argThat(
          equals({'filter': 'year'}),
          named: 'queryParameters',
        ),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      ));
    });
  });

  test('getNewsPosts', () async {
    final dio = MockDio();
    final api = McndApi(dio);
    final expectedResponseJson = [apiNewsPostResponse];
    final expectedResponseParsed = [ApiNewsPost.fromJson(expectedResponseJson.first)];

    dio.whenAnyGet().thenAnswer((_) => Future.value(Response<dynamic>(
          data: expectedResponseJson,
          requestOptions: RequestOptions(path: ''),
        )));

    final result = await api.getNewsPosts();

    expect(result, expectedResponseParsed);
  });

  test('getFeaturedMedia with id', () async {
    final dio = MockDio();
    final api = McndApi(dio);
    const mediaId = 55;
    final expectedResponseJson = apiMediaResponse;
    final expectedResponseParsed = ApiFeaturedMedia.fromJson(expectedResponseJson);

    dio.whenAnyGet().thenAnswer((_) => Future.value(Response<dynamic>(
          data: expectedResponseJson,
          requestOptions: RequestOptions(path: ''),
        )));

    final result = await api.getFeaturedMedia(mediaId);

    expect(result, expectedResponseParsed);

    verify(dio.get<dynamic>(
      argThat(endsWith(mediaId.toString())),
      queryParameters: anyNamed('options'),
      options: anyNamed('options'),
      cancelToken: anyNamed('cancelToken'),
      onReceiveProgress: anyNamed('onReceiveProgress'),
    ));
  });
}
