class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final String description;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final double feelsLike;
  final int cloudiness;
  final DateTime dateTime;
  final String country;
  final int sunrise;
  final int sunset;
  final double tempMin;
  final double tempMax;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.feelsLike,
    required this.cloudiness,
    required this.dateTime,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.tempMin,
    required this.tempMax,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'] ?? '',
      description: json['weather'][0]['description'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'] ?? 0,
      feelsLike: json['main']['feels_like'].toDouble(),
      cloudiness: json['clouds']['all'] ?? 0,
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      country: json['sys']['country'] ?? '',
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
    );
  }
}

class ForecastWeather {
  final DateTime dateTime;
  final double temperature;
  final String condition;
  final String description;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final int cloudiness;

  ForecastWeather({
    required this.dateTime,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.cloudiness,
  });

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'] ?? '',
      description: json['weather'][0]['description'] ?? '',
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: json['wind']['speed'].toDouble(),
      cloudiness: json['clouds']['all'] ?? 0,
    );
  }
}
