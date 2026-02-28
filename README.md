# Weather App 🌤️

A beautiful, modern weather application built with Flutter featuring stunning UI, smooth animations, and real-time weather data.

## ✨ Features

- 🌍 **Real-time Weather Data** - Powered by OpenWeatherMap API
- 📍 **Location-Based Forecasts** - Automatic location detection
- 🎨 **Beautiful UI** - Modern glass morphism design with gradient backgrounds
- 🌈 **Dynamic Themes** - Colors change based on weather conditions
- 📊 **7-Day Forecast** - Extended weather predictions
- 💫 **Smooth Animations** - Fluid transitions and animated weather icons
- 🔍 **City Search** - Search weather for any city worldwide
- 🌡️ **Temperature Units** - Toggle between Celsius and Fahrenheit
- 📱 **Responsive Design** - Optimized for all screen sizes

## 🎯 UI Highlights

- **Glass Morphism Effects** - Frosted glass UI components
- **Gradient Backgrounds** - Dynamic colors matching weather conditions
- **Animated Weather Icons** - Smooth, pulsing weather icons
- **Pull to Refresh** - Intuitive gesture to update weather
- **Beautiful Typography** - Custom Poppins font family
- **Weather Details Cards** - Humidity, wind speed, pressure, and more

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- OpenWeatherMap API Key

### Installation

1. **Clone or navigate to the project directory**

2. **Get an OpenWeatherMap API Key**
   - Visit [OpenWeatherMap](https://openweathermap.org/api)
   - Sign up for a free account
   - Generate an API key

3. **Add your API key**
   - Open `lib/services/weather_service.dart`
   - Replace `YOUR_API_KEY_HERE` with your actual API key:
   ```dart
   static const String _apiKey = 'your_actual_api_key_here';
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

- **provider** - State management
- **http** - API requests
- **geolocator** - Location services
- **geocoding** - Reverse geocoding
- **intl** - Date formatting
- **flutter_animate** - Advanced animations
- **shimmer** - Loading effects
- **shared_preferences** - Local storage

## 🛠️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── weather_model.dart    # Weather data models
├── providers/
│   └── weather_provider.dart # State management
├── screens/
│   └── home_screen.dart      # Main weather screen
├── services/
│   ├── weather_service.dart  # API integration
│   └── location_service.dart # Location handling
├── utils/
│   └── weather_utils.dart    # Helper functions
└── widgets/
    ├── animated_weather_icon.dart
    ├── forecast_card.dart
    ├── search_dialog.dart
    └── weather_detail_card.dart
```

## 🎨 Customization

### Change Color Scheme
Edit the gradient colors in `lib/utils/weather_utils.dart`:
```dart
static List<Color> getWeatherGradient(String condition, bool isDay) {
  // Customize your gradients here
}
```

### Modify Animations
Adjust animation durations in widget files:
```dart
AnimationController(
  duration: const Duration(milliseconds: 1500),
  vsync: this,
);
```

## 📱 Permissions

### Android
Location permissions are configured in `android/app/src/main/AndroidManifest.xml`

### iOS
Location permissions are configured in `ios/Runner/Info.plist`

## 🌟 Screenshots & Features

- **Home Screen**: Current weather with animated icons
- **Weather Details**: Humidity, wind speed, pressure, feels like
- **7-Day Forecast**: Scroll through upcoming weather
- **Search**: Find weather for any city
- **Loading States**: Beautiful loading animations
- **Error Handling**: User-friendly error messages

## 🔧 Troubleshooting

### Location Not Working
- Ensure location services are enabled on your device
- Check app permissions in device settings
- Grant location permission when prompted

### API Errors
- Verify your API key is correct
- Check your internet connection
- Ensure you haven't exceeded API rate limits (free tier: 60 calls/minute)

### Build Issues
```bash
flutter clean
flutter pub get
flutter run
```

## 📝 TODO / Future Enhancements

- [ ] Add weather alerts and notifications
- [ ] Hourly forecast view
- [ ] Multiple location management
- [ ] Weather radar maps
- [ ] Dark/Light theme toggle
- [ ] Weather widgets
- [ ] Share weather information
- [ ] Historical weather data

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Credits

- Weather data provided by [OpenWeatherMap](https://openweathermap.org/)
- Icons from Material Design
- Animations powered by Flutter

---

**Made with ❤️ and Flutter**

Enjoy your beautiful weather app! 🌤️
