import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/weather_provider.dart';
import '../../utils/app_theme.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          final weather = weatherProvider.currentWeather;

          if (weather == null) {
            return const Center(child: Text('No weather data available'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          weather.location,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${weather.temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(weather.condition),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '7-Day Forecast',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                ...weather.dailyForecasts.map((forecast) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const Icon(Icons.wb_cloudy),
                        title: Text(forecast.day),
                        subtitle: Text(forecast.condition),
                        trailing: Text('${forecast.maxTemp.toStringAsFixed(0)}° / ${forecast.minTemp.toStringAsFixed(0)}°'),
                      ),
                    )),
                if (weather.alerts.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Weather Alerts',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  ...weather.alerts.map((alert) => Card(
                        color: AppColors.warning.withValues(alpha: 0.1),
                        child: ListTile(
                          leading: const Icon(Icons.warning_amber, color: AppColors.warning),
                          title: Text(alert.message),
                          subtitle: Text(alert.type),
                        ),
                      )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
