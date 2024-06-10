import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            '${weather.temperature}°C',
            style: TextStyle(fontSize: 48),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('http://openweathermap.org/img/w/${weather.weatherIcon}.png'),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Давление: ${weather.pressure} hPa'),
                  Text('Влажность: ${weather.humidity}%'),
                  Text('Скорость ветра: ${weather.windSpeed} м/с'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
