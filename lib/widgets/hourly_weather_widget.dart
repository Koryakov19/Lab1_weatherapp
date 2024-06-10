import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:intl/intl.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final List<HourlyWeather> hourlyWeather;

  const HourlyWeatherWidget({Key? key, required this.hourlyWeather}) : super(key: key);

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('d MMMM yyyy HH:mm', 'ru').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    print('Building HourlyWeatherWidget with data: $hourlyWeather');
    if (hourlyWeather.isEmpty) {
      return Text('Нет почасовых данных.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: hourlyWeather.map((weather) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDate(weather.time), style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    Image.network('http://openweathermap.org/img/w/${weather.weatherIcon}.png'),
                    SizedBox(width: 10),
                    Text('${weather.temperature}°C', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
