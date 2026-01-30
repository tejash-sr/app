// part 'farm_model.g.dart';  // Commented out - not using Hive type adapters

// @HiveType(typeId: 1)
class FarmModel {
  // @HiveField(0)
  final String id;

  // @HiveField(1)
  final String farmerId;

  // @HiveField(2)
  final String name;

  // @HiveField(3)
  final double area; // in acres

  // @HiveField(4)
  final String soilType;

  // @HiveField(5)
  final double latitude;

  // @HiveField(6)
  final double longitude;

  // @HiveField(7)
  final String location;

  // @HiveField(8)
  final List<String> currentCrops;

  // @HiveField(9)
  final Map<String, dynamic>? cropHistory;

  // @HiveField(10)
  final DateTime createdAt;

  // @HiveField(11)
  final double? waterAvailability; // percentage

  // @HiveField(12)
  final String? irrigationType;

  FarmModel({
    required this.id,
    required this.farmerId,
    required this.name,
    required this.area,
    required this.soilType,
    required this.latitude,
    required this.longitude,
    required this.location,
    this.currentCrops = const [],
    this.cropHistory,
    required this.createdAt,
    this.waterAvailability,
    this.irrigationType,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
      id: json['id'] as String,
      farmerId: json['farmerId'] as String,
      name: json['name'] as String,
      area: (json['area'] as num).toDouble(),
      soilType: json['soilType'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      location: json['location'] as String,
      currentCrops: (json['currentCrops'] as List?)?.cast<String>() ?? [],
      cropHistory: json['cropHistory'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      waterAvailability: (json['waterAvailability'] as num?)?.toDouble(),
      irrigationType: json['irrigationType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmerId': farmerId,
      'name': name,
      'area': area,
      'soilType': soilType,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
      'currentCrops': currentCrops,
      'cropHistory': cropHistory,
      'createdAt': createdAt.toIso8601String(),
      'waterAvailability': waterAvailability,
      'irrigationType': irrigationType,
    };
  }
}
