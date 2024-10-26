import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/apis/base_api.dart';

class WeatherApi extends BaseApi {
  final String apiKey = "your_api_key";

  getWeatherForCity(String cityName) async {
    try {
      final response = await dio.post("?q=$cityName&appid=$apiKey");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to get weather for city");
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  getWeatherForCurrentCity() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double log = position.longitude;
    try {
      final response =
          await dio.post("?lat=$lat&lon=$log&appid=$apiKey&units=metric");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to get weather for city");
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
