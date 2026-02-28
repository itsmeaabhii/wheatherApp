import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/weather_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3A59),
              height: 1.0,
            ),
            displayMedium: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E3A59),
            ),
            titleLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E3A59),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Color(0xFF9CA3AF),
            ),
          ),
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF6366F1),
            secondary: const Color(0xFFF59E0B),
            surface: Colors.white,
            background: const Color(0xFFF5F5F5),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
