import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio get httpClient {
    final dio = Dio();

    dio.options.baseUrl = 'https://mcnd.ie/wp-json/dpt/v1/';

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger());
    }

    return dio;
  }
}
