import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/farm_model.dart';

class FarmProvider extends ChangeNotifier {
  List<FarmModel> _farms = [];
  FarmModel? _selectedFarm;
  bool _isLoading = false;
  String? _errorMessage;

  List<FarmModel> get farms => _farms;
  FarmModel? get selectedFarm => _selectedFarm;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final Box _farmsBox = Hive.box('farms');

  FarmProvider() {
    _loadFarms();
  }

  Future<void> _loadFarms() async {
    _isLoading = true;
    notifyListeners();

    try {
      final farmsData = _farmsBox.values.toList();
      _farms = farmsData
          .map((data) => FarmModel.fromJson(Map<String, dynamic>.from(data)))
          .toList();

      if (_farms.isEmpty) {
        // Create demo farms
        await _createDemoFarms();
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load farms: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _createDemoFarms() async {
    final demoFarms = [
      FarmModel(
        id: 'farm_001',
        farmerId: 'user_001',
        name: 'Green Valley Farm',
        area: 5.5,
        soilType: 'Red Loamy Soil',
        latitude: 12.9716,
        longitude: 77.5946,
        location: 'Bangalore Rural, Karnataka',
        currentCrops: ['Tomato', 'Cucumber'],
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
        waterAvailability: 75.0,
        irrigationType: 'Drip Irrigation',
        cropHistory: {
          'lastSeason': ['Rice', 'Wheat'],
          'yield': {'Rice': 3.2, 'Wheat': 2.8},
        },
      ),
      FarmModel(
        id: 'farm_002',
        farmerId: 'user_001',
        name: 'Sunrise Organic Farm',
        area: 3.2,
        soilType: 'Black Cotton Soil',
        latitude: 13.0827,
        longitude: 80.2707,
        location: 'Chennai, Tamil Nadu',
        currentCrops: ['Chili', 'Brinjal'],
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        waterAvailability: 60.0,
        irrigationType: 'Sprinkler',
      ),
    ];

    for (var farm in demoFarms) {
      await _farmsBox.put(farm.id, farm.toJson());
    }

    _farms = demoFarms;
  }

  Future<bool> addFarm(FarmModel farm) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _farmsBox.put(farm.id, farm.toJson());
      _farms.add(farm);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to add farm: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateFarm(FarmModel farm) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _farmsBox.put(farm.id, farm.toJson());
      final index = _farms.indexWhere((f) => f.id == farm.id);
      if (index != -1) {
        _farms[index] = farm;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update farm: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void selectFarm(FarmModel farm) {
    _selectedFarm = farm;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
