import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utils/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/farm/farm_management_screen.dart';
import 'screens/crop/disease_detection_screen.dart';
import 'screens/crop/crop_recommendation_screen.dart';
import 'screens/weather/weather_screen.dart';
import 'screens/price/price_forecast_screen.dart';
import 'screens/marketplace/marketplace_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/farm_provider.dart';
import 'providers/weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Open boxes for data storage
  await Hive.openBox('users');
  await Hive.openBox('farms');
  await Hive.openBox('crops');
  await Hive.openBox('marketplace');
  await Hive.openBox('settings');

  runApp(const AgriSenseApp());
}

class AgriSenseApp extends StatelessWidget {
  const AgriSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FarmProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'AgriSense - AI Crop Intelligence',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/farm': (context) => const FarmManagementScreen(),
          '/disease-detection': (context) => const DiseaseDetectionScreen(),
          '/crop-recommendation': (context) =>
              const CropRecommendationScreen(),
          '/weather': (context) => const WeatherScreen(),
          '/price-forecast': (context) => const PriceForecastScreen(),
          '/marketplace': (context) => const MarketplaceScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
