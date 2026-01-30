import 'package:flutter/foundation.dart';
import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _currentWeather;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String location) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Demo weather data
      _currentWeather = WeatherModel(
        location: location,
        temperature: 28.5,
        humidity: 65.0,
        rainfall: 2.5,
        windSpeed: 12.0,
        condition: 'Partly Cloudy',
        forecast:
            'Warm and humid conditions expected. Light rainfall possible in the evening. Good conditions for irrigation.',
        dailyForecasts: _generateDailyForecasts(),
        alerts: _generateWeatherAlerts(),
        timestamp: DateTime.now(),
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch weather: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  List<DailyForecast> _generateDailyForecasts() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final conditions = [
      'Sunny',
      'Partly Cloudy',
      'Cloudy',
      'Rainy',
      'Sunny',
      'Partly Cloudy',
      'Sunny'
    ];

    return List.generate(7, (index) {
      return DailyForecast(
        day: days[index],
        maxTemp: 30.0 + (index % 3),
        minTemp: 22.0 + (index % 2),
        rainfall: index == 3 ? 15.0 : (index % 2 == 0 ? 0 : 2.0),
        condition: conditions[index],
      );
    });
  }

  List<WeatherAlert> _generateWeatherAlerts() {
    return [
      WeatherAlert(
        type: 'rainfall',
        severity: 'medium',
        message:
            'Moderate rainfall expected in 2 days. Plan your irrigation accordingly.',
        validUntil: DateTime.now().add(const Duration(days: 2)),
      ),
      WeatherAlert(
        type: 'temperature',
        severity: 'low',
        message:
            'Temperature may rise above 35°C next week. Monitor crop water stress.',
        validUntil: DateTime.now().add(const Duration(days: 7)),
      ),
    ];
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
