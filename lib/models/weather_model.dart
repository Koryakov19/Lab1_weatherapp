class Weather {
  final String cityName;
  final double temperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final String weatherIcon;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weatherIcon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      weatherIcon: json['weather'][0]['icon'],
    );
  }
}

class HourlyWeather {
  final String time;
  final double temperature;
  final String weatherIcon;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherIcon,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: json['dt_txt'],
      temperature: json['main']['temp'].toDouble(),
      weatherIcon: json['weather'][0]['icon'],
    );
  }
}
