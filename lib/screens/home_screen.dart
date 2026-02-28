import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../utils/weather_utils.dart';
import '../widgets/weather_detail_card.dart';
import '../widgets/forecast_card.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/search_dialog.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Fetch weather on app start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeatherByLocation()
          .then((_) {
        _fadeController.forward();
        _slideController.forward();
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        final weather = weatherProvider.currentWeather;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            child: weatherProvider.isLoading
                ? _buildLoadingState(context)
                : weatherProvider.error != null
                    ? _buildErrorState(context, weatherProvider)
                    : weather != null
                        ? _buildWeatherContent(context, weatherProvider, weather)
                        : _buildEmptyState(context),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 3,
          ),
          const SizedBox(height: 24),
          Text(
            'Getting weather data...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WeatherProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              provider.error ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => provider.fetchWeatherByLocation(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'No weather data available',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildWeatherContent(
    BuildContext context,
    WeatherProvider provider,
    weather,
  ) {
    return RefreshIndicator(
      onRefresh: () => provider.fetchWeatherByLocation(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Header
            _buildHeader(context, provider),
            const SizedBox(height: 20),
            
            // Main Weather Card
            _buildMainWeatherCard(context, weather, provider),
            const SizedBox(height: 24),
            
            // Weather Details Grid
            _buildWeatherDetailsGrid(context, weather),
            const SizedBox(height: 24),
            
            // Hourly Forecast
            if (provider.forecast.isNotEmpty)
              _buildHourlyForecast(context, provider),
            if (provider.forecast.isNotEmpty)
              const SizedBox(height: 24),
            
            // Daily Forecast
            if (provider.forecast.isNotEmpty)
              _buildDailyForecast(context, provider),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WeatherProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.currentWeather?.cityName ?? 'Unknown',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${provider.currentWeather?.country ?? ''} • ${DateFormat('MMM dd, yyyy').format(DateTime.now())}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              _buildIconButton(
                icon: Icons.search,
                onTap: () => _showSearchDialog(context, provider),
              ),
              const SizedBox(width: 12),
              _buildIconButton(
                icon: Icons.my_location,
                onTap: () => provider.fetchWeatherByLocation(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: const Color(0xFF2E3A59),
        ),
      ),
    );
  }

  Widget _buildMainWeatherCard(
    BuildContext context,
    weather,
    WeatherProvider provider,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6366F1),
            const Color(0xFF8B5CF6),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Weather Icon
          Icon(
            WeatherUtils.getWeatherIcon(weather.condition),
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          
          // Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${provider.convertTemperature(weather.temperature).round()}',
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              Text(
                provider.temperatureUnit,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Condition
          Text(
            weather.condition,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            weather.description.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 1.5,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 24),
          
          // Min/Max Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_downward,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${weather.tempMin.round()}°',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: 1,
                height: 20,
                color: Colors.white.withOpacity(0.3),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${weather.tempMax.round()}°',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsGrid(BuildContext context, weather) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          WeatherDetailCard(
            icon: Icons.water_drop_outlined,
            label: 'Humidity',
            value: '${weather.humidity}%',
          ),
          WeatherDetailCard(
            icon: Icons.air,
            label: 'Wind Speed',
            value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
          ),
          WeatherDetailCard(
            icon: Icons.thermostat_outlined,
            label: 'Feels Like',
            value: '${weather.feelsLike.round()}°',
          ),
          WeatherDetailCard(
            icon: Icons.compress,
            label: 'Pressure',
            value: '${weather.pressure} hPa',
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast(BuildContext context, WeatherProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Today',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: provider.forecast.length > 8 ? 8 : provider.forecast.length,
            itemBuilder: (context, index) {
              final forecast = provider.forecast[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index < 7 ? 12 : 0,
                ),
                child: HourlyForecastCard(
                  forecast: forecast,
                  isCelsius: provider.isCelsius,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDailyForecast(BuildContext context, WeatherProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '7-Day Forecast',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: provider.forecast.length,
            itemBuilder: (context, index) {
              final forecast = provider.forecast[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index < provider.forecast.length - 1 ? 16 : 0,
                ),
                child: ForecastCard(
                  forecast: forecast,
                  isCelsius: provider.isCelsius,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showSearchDialog(BuildContext context, WeatherProvider provider) {
    showDialog(
      context: context,
      builder: (context) => SearchDialog(provider: provider),
    );
  }
}
