#!/bin/bash

echo "🌤️  Weather App Setup Script"
echo "================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null
then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter is installed"
echo ""

# Check Flutter version
echo "📦 Flutter Version:"
flutter --version
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
echo ""

# Get dependencies
echo "📥 Installing dependencies..."
flutter pub get
echo ""

# Check for issues
echo "🔍 Checking for issues..."
flutter doctor
echo ""

echo "================================"
echo "✨ Setup Complete!"
echo ""
echo "⚠️  IMPORTANT: Don't forget to:"
echo "1. Get your OpenWeatherMap API key from: https://openweathermap.org/api"
echo "2. Add it to lib/services/weather_service.dart"
echo "   Replace 'YOUR_API_KEY_HERE' with your actual API key"
echo ""
echo "🚀 To run the app:"
echo "   flutter run"
echo ""
echo "Happy coding! 🎉"
