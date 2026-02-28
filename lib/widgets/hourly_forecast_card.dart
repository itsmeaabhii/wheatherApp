import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../utils/weather_utils.dart';
import 'package:intl/intl.dart';

class HourlyForecastCard extends StatelessWidget {
  final ForecastWeather forecast;
  final bool isCelsius;

  const HourlyForecastCard({
    super.key,
    required this.forecast,
    required this.isCelsius,
  });

  @override
  Widget build(BuildContext context) {
    final temp = isCelsius
        ? forecast.temperature
        : (forecast.temperature * 9 / 5) + 32;
    final unit = isCelsius ? '°' : '°';
    final time = DateFormat('HH:mm').format(forecast.dateTime);

    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9CA3AF),
            ),
          ),
          Icon(
            WeatherUtils.getWeatherIcon(forecast.condition),
            size: 32,
            color: const Color(0xFF6366F1),
          ),
          Text(
            '${temp.round()}$unit',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3A59),
            ),
          ),
        ],
      ),
    );
  }
}
