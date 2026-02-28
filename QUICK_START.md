# 🚀 Quick Start Guide

## Step-by-Step Setup

### 1️⃣ Get Your API Key (FREE)

1. Go to [OpenWeatherMap](https://openweathermap.org/api)
2. Click "Sign Up" (top right)
3. Create a free account
4. Go to "API keys" tab
5. Copy your API key

**Time: 2-3 minutes**

---

### 2️⃣ Add API Key to the App

1. Open the file: `lib/services/weather_service.dart`
2. Find line 7:
   ```dart
   static const String _apiKey = 'YOUR_API_KEY_HERE';
   ```
3. Replace `YOUR_API_KEY_HERE` with your actual API key:
   ```dart
   static const String _apiKey = 'abc123your-actual-key-here';
   ```
4. Save the file

---

### 3️⃣ Run Setup Script

**On macOS/Linux:**
```bash
./setup.sh
```

**Or manually:**
```bash
flutter clean
flutter pub get
flutter doctor
```

---

### 4️⃣ Run the App

```bash
flutter run
```

**Or in VS Code:**
- Press `F5`
- Or click the "Run" button (top right)

---

## 🎯 First Launch

When you first open the app:

1. **Grant Location Permission** - The app will ask for location access
2. **Wait for Loading** - It will fetch weather data
3. **Enjoy!** - Your beautiful weather app is ready!

---

## 🎨 App Features

### Main Screen
- Current temperature with animated icon
- Weather condition and description
- City name and country
- Detailed weather info (humidity, wind, pressure)

### Actions
- 🔍 **Search Icon** (top right) - Search any city
- 📍 **Location Icon** (top right) - Refresh current location
- 🔄 **Pull Down** - Refresh weather data

### 7-Day Forecast
- Scroll horizontally to see future weather
- Daily temperature and conditions
- Beautiful glass cards

---

## 💡 Tips

### Best Practices
- Internet connection required
- Location services must be enabled
- API has 60 calls/minute limit (free tier)

### Customize It!
- Change colors in `lib/utils/weather_utils.dart`
- Modify animations in widget files
- Add your own features!

---

## 🐛 Troubleshooting

### App won't run?
```bash
flutter clean
flutter pub get
flutter run
```

### No weather data?
- Check your API key is correct
- Verify internet connection
- Enable location services

### Location not working?
- Go to device Settings
- Find the Weather App
- Enable Location Permission

---

## 📱 Test the App

### Try These Features:
1. ✅ Open app and see your local weather
2. ✅ Pull down to refresh
3. ✅ Tap search icon and try: "London", "Tokyo", "New York"
4. ✅ Tap location icon to reset to your location
5. ✅ Scroll through the 7-day forecast

---

## 🎉 You're All Set!

Your beautiful weather app is ready to use!

**Questions?** Check the README.md file for more details.

**Enjoy your new app!** 🌤️
