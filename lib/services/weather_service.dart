import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  // OpenWeatherMap API key
  // NOTE: New API keys take 1-2 hours to activate after creation
  // If you get 401 errors, please wait or generate a new key at:
  // https://home.openweathermap.org/api_keys
  static const String _apiKey = '65c42783c3388ae8d75cf79673e4e7c1';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> getCurrentWeather(double lat, double lon) async {
    final url = Uri.parse(
      '$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric',
    );

    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Weather.fromJson(data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  Future<Weather> getWeatherByCity(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric',
    );

    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Weather.fromJson(data);
      } else {
        throw Exception('City not found');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  Future<List<ForecastWeather>> getForecast(double lat, double lon) async {
    final url = Uri.parse(
      '$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric',
    );

    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> forecastList = data['list'];
        
        // Get daily forecasts (one per day at noon)
        List<ForecastWeather> forecasts = [];
        Set<String> processedDates = {};
        
        for (var item in forecastList) {
          final forecast = ForecastWeather.fromJson(item);
          final dateKey = '${forecast.dateTime.year}-${forecast.dateTime.month}-${forecast.dateTime.day}';
          
          // Take the forecast closest to noon for each day
          if (!processedDates.contains(dateKey) && forecast.dateTime.hour >= 12) {
            forecasts.add(forecast);
            processedDates.add(dateKey);
          }
          
          if (forecasts.length >= 7) break;
        }
        
        return forecasts;
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      throw Exception('Error fetching forecast: $e');
    }
  }
}
