class WeatherModel {
  final String location;
  final double temperature; // celsius
  final double humidity; // percentage
  final double rainfall; // mm
  final double windSpeed; // km/h
  final String condition; // sunny, cloudy, rainy, etc.
  final String forecast; // 7-day forecast description
  final List<DailyForecast> dailyForecasts;
  final List<WeatherAlert> alerts;
  final DateTime timestamp;

  WeatherModel({
    required this.location,
    required this.temperature,
    required this.humidity,
    required this.rainfall,
    required this.windSpeed,
    required this.condition,
    required this.forecast,
    required this.dailyForecasts,
    required this.alerts,
    required this.timestamp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      rainfall: (json['rainfall'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      condition: json['condition'] as String,
      forecast: json['forecast'] as String,
      dailyForecasts: (json['dailyForecasts'] as List)
          .map((e) => DailyForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
      alerts: (json['alerts'] as List)
          .map((e) => WeatherAlert.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'temperature': temperature,
      'humidity': humidity,
      'rainfall': rainfall,
      'windSpeed': windSpeed,
      'condition': condition,
      'forecast': forecast,
      'dailyForecasts': dailyForecasts.map((e) => e.toJson()).toList(),
      'alerts': alerts.map((e) => e.toJson()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class DailyForecast {
  final String day;
  final double maxTemp;
  final double minTemp;
  final double rainfall;
  final String condition;

  DailyForecast({
    required this.day,
    required this.maxTemp,
    required this.minTemp,
    required this.rainfall,
    required this.condition,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      day: json['day'] as String,
      maxTemp: (json['maxTemp'] as num).toDouble(),
      minTemp: (json['minTemp'] as num).toDouble(),
      rainfall: (json['rainfall'] as num).toDouble(),
      condition: json['condition'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'rainfall': rainfall,
      'condition': condition,
    };
  }
}

class WeatherAlert {
  final String type; // storm, flood, drought, frost
  final String severity; // low, medium, high, critical
  final String message;
  final DateTime validUntil;

  WeatherAlert({
    required this.type,
    required this.severity,
    required this.message,
    required this.validUntil,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      type: json['type'] as String,
      severity: json['severity'] as String,
      message: json['message'] as String,
      validUntil: DateTime.parse(json['validUntil'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'severity': severity,
      'message': message,
      'validUntil': validUntil.toIso8601String(),
    };
  }
}
