import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/hourly_weather.dart';

String apiKey = 'de58ba041387983ff1fdc7b35c9dd9b6';

Future<Weather> getWeatherByLocation(double latitude, double longitude) async {
  WeatherFactory wf = WeatherFactory(apiKey);
  Weather w = await wf.currentWeatherByLocation(latitude, longitude);
  return w;
}


Future<List<HourlyWeather>> getThreeHourlyWeatherByLocation(double latitude, double longitude) async {
  final url = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<HourlyWeather> threeHourlyWeather = [];
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(data['city']['sunrise'] * 1000);
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(data['city']['sunset'] * 1000);

    for (var hourData in data['list']) {
      HourlyWeather weather = HourlyWeather.fromJson(hourData, sunrise, sunset);
      threeHourlyWeather.add(weather);
    }
    
    return threeHourlyWeather;
  } else {
    throw Exception('Failed to load 3-hourly weather data');
  }
}






