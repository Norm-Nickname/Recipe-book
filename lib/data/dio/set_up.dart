import 'package:flutter_application_2/di/di.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

void setUpDio() {
  dio.options.baseUrl =
      'https://www.themealdb.com/api/json/v1/1'; // общая часть адресов запросов
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}
