import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/widgets/weather_widget.dart';
import 'package:weather_app/widgets/hourly_weather_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ru', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Прогноз погоды',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  late Future<Weather> _weather;
  late Future<List<HourlyWeather>> _hourlyWeather;
  bool _hasSearched = false;

  void _fetchWeather() {
    setState(() {
      _weather = _weatherService.getWeather(_cityController.text);
      _hourlyWeather = _weatherService.getHourlyWeather(_cityController.text);
      _hasSearched = true;
      print('Fetching weather for ${_cityController.text}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз погоды'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Введите название города',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _fetchWeather,
                  ),
                ),
                onSubmitted: (value) => _fetchWeather(),
              ),
              SizedBox(height: 20),
              _hasSearched
                  ? FutureBuilder<Weather>(
                future: _weather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('Нет данных');
                  } else {
                    return WeatherWidget(weather: snapshot.data!);
                  }
                },
              )
                  : Text('Пожалуйста, введите название города, чтобы получить информацию о погоде.'),
              SizedBox(height: 20),
              _hasSearched
                  ? FutureBuilder<List<HourlyWeather>>(
                future: _hourlyWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('Нет данных');
                  } else {
                    print('Hourly Weather Data: ${snapshot.data}');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Прогноз погоды на ближайшие дни:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HourlyWeatherWidget(hourlyWeather: snapshot.data!),
                      ],
                    );
                  }
                },
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
