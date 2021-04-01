import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
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
    final res = when(this.get(
      any,
      queryParameters: anyNamed("queryParameters"),
      options: anyNamed("options"),
      cancelToken: anyNamed("cancelToken"),
      onReceiveProgress: anyNamed("onReceiveProgress"),
    ));

    return res;
  }
}

@GenerateMocks([Mapper, Dio])
void main() {
  test(
      "when McndApi called with TODAY filter it adds it to the arguments and receives correct result",
      () async {
    final dio = MockDio();
    final mapper = MockMapper();
    final api = McndApi(dio, mapper);

    final expectedResponseJson = [apiPrayerDayResponse];
    final expectedResponseParsed = Mapper().mapList(
      expectedResponseJson,
      (json) => ApiPrayerTime.fromJson(json),
    );

    dio.whenAnyGet().thenAnswer((_) => Future.value(Response(
          data: expectedResponseJson,
          requestOptions: RequestOptions(path: ''),
        )));

    final result = await api.getPrayerTime(PrayerTimeFilter.TODAY);

    expect(result, expectedResponseParsed);

    verify(dio.get(
      any,
      queryParameters: argThat(
        equals({"filter": "today"}),
        named: "queryParameters",
      ),
      options: anyNamed("options"),
      cancelToken: anyNamed("cancelToken"),
      onReceiveProgress: anyNamed("onReceiveProgress"),
    ));
  });

  test(
      "when McndApi called with (MONTH, YEAR) filter it adds it to the arguments and receives correct result (unwrapped)",
      () async {
    final dio = MockDio();
    final mapper = MockMapper();
    final api = McndApi(dio, mapper);

    final expectedResponseJson = [
      [
        apiPrayerDayResponse,
        apiPrayerDayResponse,
        apiPrayerDayResponse,
        apiPrayerDayResponse,
        apiPrayerDayResponse,
      ]
    ];
    final expectedResponseParsed = Mapper().mapList(
      expectedResponseJson.first,
      (json) => ApiPrayerTime.fromJson(json),
    );

    dio.whenAnyGet().thenAnswer((_) => Future.value(Response(
          data: expectedResponseJson,
          requestOptions: RequestOptions(path: ''),
        )));

    final resultMonth = await api.getPrayerTime(PrayerTimeFilter.MONTH);
    expect(resultMonth, expectedResponseParsed);

    final resultYear = await api.getPrayerTime(PrayerTimeFilter.YEAR);
    expect(resultYear, expectedResponseParsed);

    verify(dio.get(
      any,
      queryParameters: argThat(
        equals({"filter": "month"}),
        named: "queryParameters",
      ),
      options: anyNamed("options"),
      cancelToken: anyNamed("cancelToken"),
      onReceiveProgress: anyNamed("onReceiveProgress"),
    ));

    verify(dio.get(
      any,
      queryParameters: argThat(
        equals({"filter": "year"}),
        named: "queryParameters",
      ),
      options: anyNamed("options"),
      cancelToken: anyNamed("cancelToken"),
      onReceiveProgress: anyNamed("onReceiveProgress"),
    ));
  });
}
