import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  Weather? _currentWeather;
  List<ForecastWeather> _forecast = [];
  bool _isLoading = false;
  String? _error;
  bool _isCelsius = true;

  Weather? get currentWeather => _currentWeather;
  List<ForecastWeather> get forecast => _forecast;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isCelsius => _isCelsius;

  Future<void> fetchWeatherByLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final position = await _locationService.getCurrentLocation();
      
      _currentWeather = await _weatherService.getCurrentWeather(
        position.latitude,
        position.longitude,
      );
      
      _forecast = await _weatherService.getForecast(
        position.latitude,
        position.longitude,
      );
      
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentWeather = null;
      _forecast = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCity(String cityName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentWeather = await _weatherService.getWeatherByCity(cityName);
      
      // Get forecast using the city's coordinates
      // For simplicity, using a dummy coordinate or you can extract from weather response
      _forecast = [];
      
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleTemperatureUnit() {
    _isCelsius = !_isCelsius;
    notifyListeners();
  }

  double convertTemperature(double temp) {
    return _isCelsius ? temp : (temp * 9 / 5) + 32;
  }

  String get temperatureUnit => _isCelsius ? '°C' : '°F';

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
