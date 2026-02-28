import 'package:flutter/material.dart';

class WeatherUtils {
  static IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'fog':
      case 'haze':
        return Icons.cloud_queue;
      default:
        return Icons.wb_cloudy;
    }
  }

  static List<Color> getWeatherGradient(String condition, bool isDay) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return isDay
            ? [const Color(0xFF4A90E2), const Color(0xFF50C878)]
            : [const Color(0xFF0F2027), const Color(0xFF203A43), const Color(0xFF2C5364)];
      case 'clouds':
        return isDay
            ? [const Color(0xFF757F9A), const Color(0xFFD7DDE8)]
            : [const Color(0xFF1e3c72), const Color(0xFF2a5298)];
      case 'rain':
      case 'drizzle':
        return [const Color(0xFF373B44), const Color(0xFF4286f4)];
      case 'thunderstorm':
        return [const Color(0xFF283048), const Color(0xFF859398)];
      case 'snow':
        return [const Color(0xFFE6DADA), const Color(0xFF274046)];
      case 'mist':
      case 'fog':
      case 'haze':
        return [const Color(0xFF606c88), const Color(0xFF3f4c6b)];
      default:
        return isDay
            ? [const Color(0xFF4A90E2), const Color(0xFF7B68EE)]
            : [const Color(0xFF0D1B2A), const Color(0xFF1B263B)];
    }
  }

  static String getWeatherAnimation(String condition) {
    // Return animation asset paths or lottie URLs
    switch (condition.toLowerCase()) {
      case 'clear':
        return '☀️';
      case 'clouds':
        return '☁️';
      case 'rain':
        return '🌧️';
      case 'thunderstorm':
        return '⛈️';
      case 'snow':
        return '❄️';
      case 'mist':
      case 'fog':
        return '🌫️';
      default:
        return '🌤️';
    }
  }

  static String formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String getDayName(DateTime dateTime) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dateTime.weekday - 1];
  }

  static bool isDay(int sunrise, int sunset) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now >= sunrise && now < sunset;
  }

  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
