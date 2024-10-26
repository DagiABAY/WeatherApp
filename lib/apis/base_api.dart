import 'package:dio/dio.dart';

class BaseApi {
  final dio = Dio(
      BaseOptions(baseUrl: "https://api.openweathermap.org/data/2.5/weather"));
}
