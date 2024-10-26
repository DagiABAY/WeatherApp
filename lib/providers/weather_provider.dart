import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/apis/weather_api.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherProvider() {
    _checkLocationPermissions();
  }
  final Map<String, dynamic> weather = {};
  final WeatherApi weatherApi = WeatherApi();

  String backImg = "assets/images/clear.jpg";
  String iconImg = "assets/icons/Clear.png";

  Future<void> setWeatherData(String cityName) async {
    var weatherData;
    if (cityName.isEmpty) {
      weatherData = await weatherApi.getWeatherForCurrentCity();
    } else {
      weatherData = await weatherApi.getWeatherForCity(cityName);
    }

    if (weatherData != null) {
      _updateWeatherData(weatherData);
      notifyListeners();
    } else {
      throw Exception("Data not found");
    }
  }

  Future<void> setWeatherDataForCurrent() async {
    var weatherData = await weatherApi.getWeatherForCurrentCity();

    if (weatherData != null) {
      _updateWeatherData(weatherData);
      notifyListeners();
    } else {}
  }

  void _updateWeatherData(Map<String, dynamic> weatherData) {
    weather["city_name"] = weatherData["name"];
    weather["temperature"] = weatherData["main"]["temp"].toStringAsFixed(1);
    weather["main"] = weatherData["weather"][0]["main"];
    weather["temp_max"] = weatherData["main"]["temp_max"].toStringAsFixed(1);
    weather["temp_min"] = weatherData["main"]["temp_min"].toStringAsFixed(1);
    weather["sunrise"] = DateFormat('hh:mm:a').format(
        DateTime.fromMillisecondsSinceEpoch(
            weatherData["sys"]["sunrise"] * 1000));
    weather["sunset"] = DateFormat('hh:mm:a').format(
        DateTime.fromMillisecondsSinceEpoch(
            weatherData["sys"]["sunset"] * 1000));
    weather["pressure"] = weatherData["main"]["pressure"].toString();
    weather["humidity"] = weatherData["main"]["humidity"].toString();
    weather["visibility"] = weatherData["visibility"].toString();
    weather["wind_speed"] = weatherData["wind"]["speed"].toString();
    _updateWeatherImages(weather["main"]);
  }

  void _updateWeatherImages(String weatherCondition) {
    switch (weatherCondition) {
      case "Clear":
        backImg = "assets/images/clear.jpg";
        iconImg = "assets/icons/Clear.png";
        break;
      case "Clouds":
        backImg = "assets/images/clouds.jpg";
        iconImg = "assets/icons/Clouds.png";
        break;
      case "Rain":
        backImg = "assets/images/rain.jpg";
        iconImg = "assets/icons/Rain.png";
        break;
      case "Fog":
        backImg = "assets/images/fog.jpg";
        iconImg = "assets/icons/Haze.png";
        break;
      case "Thunderstorm":
        backImg = "assets/images/thunderstorm.jpg";
        iconImg = "assets/icons/Thunderstorm.png";
        break;
      default:
        backImg = "assets/images/haze.jpg";
        iconImg = "assets/icons/Haze.png";
        break;
    }
  }

  Future<bool> _checkLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
      setWeatherData('');
    }
    setWeatherData('');
    return true;
  }
}
