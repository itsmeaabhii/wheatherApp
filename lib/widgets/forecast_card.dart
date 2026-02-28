import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../utils/weather_utils.dart';

class ForecastCard extends StatelessWidget {
  final ForecastWeather forecast;
  final bool isCelsius;

  const ForecastCard({
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

    return Container(
      width: 120,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
            WeatherUtils.getDayName(forecast.dateTime),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF2E3A59),
            ),
          ),
          const SizedBox(height: 12),
          Icon(
            WeatherUtils.getWeatherIcon(forecast.condition),
            size: 40,
            color: const Color(0xFF6366F1),
          ),
          const SizedBox(height: 12),
          Text(
            '${temp.round()}$unit',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3A59),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            forecast.condition,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9CA3AF),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
