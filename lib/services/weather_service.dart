import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static const String _apiKey = '12a9e16a295c9e78488706d822a9c415';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> getWeather(String city) async {
    final response = await http.get(Uri.parse('$_baseUrl/weather?q=$city&units=metric&appid=$_apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Не удалось загрузить данные о погоде');
    }
  }

  Future<List<HourlyWeather>> getHourlyWeather(String city) async {
    final response = await http.get(Uri.parse('$_baseUrl/forecast?q=$city&units=metric&appid=$_apiKey'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['list'];
      List<HourlyWeather> hourlyWeather = data.map((json) => HourlyWeather.fromJson(json)).toList();

      // Фильтруем данные, чтобы получить прогноз на следующие 24 часа с интервалом в 5 часов
      List<HourlyWeather> filteredWeather = [];
      DateTime now = DateTime.now();

      // Печатаем все данные для отладки
      for (var weather in hourlyWeather) {
        print('Time: ${weather.time}, Temp: ${weather.temperature}°C');
      }

      for (var weather in hourlyWeather) {
        DateTime weatherTime = DateTime.parse(weather.time);
        if (weatherTime.isAfter(now) && weatherTime.difference(now).inHours % 5 == 0) {
          filteredWeather.add(weather);
          print('Added: ${weather.time} - Temp: ${weather.temperature}°C');
        }
      }

      print('Filtered Weather Data Count: ${filteredWeather.length}');

      return filteredWeather.take(5).toList(); // Получаем только 5 интервалов (5 часов каждый)
    } else {
      throw Exception('Не удалось загрузить почасовые данные о погоде');
    }
  }
}
