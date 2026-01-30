class CropRecommendationModel {
  final String cropName;
  final String cropType;
  final double expectedYield; // tons per acre
  final double expectedPrice; // per kg
  final double expectedProfit; // total
  final int growthDuration; // days
  final String season;
  final double waterRequirement; // liters per day
  final double riskScore; // 0-100
  final String soilType;
  final List<String> benefits;
  final List<String> challenges;
  final double marketDemand; // 0-100
  final String? imageUrl;

  CropRecommendationModel({
    required this.cropName,
    required this.cropType,
    required this.expectedYield,
    required this.expectedPrice,
    required this.expectedProfit,
    required this.growthDuration,
    required this.season,
    required this.waterRequirement,
    required this.riskScore,
    required this.soilType,
    required this.benefits,
    required this.challenges,
    required this.marketDemand,
    this.imageUrl,
  });

  factory CropRecommendationModel.fromJson(Map<String, dynamic> json) {
    return CropRecommendationModel(
      cropName: json['cropName'] as String,
      cropType: json['cropType'] as String,
      expectedYield: (json['expectedYield'] as num).toDouble(),
      expectedPrice: (json['expectedPrice'] as num).toDouble(),
      expectedProfit: (json['expectedProfit'] as num).toDouble(),
      growthDuration: json['growthDuration'] as int,
      season: json['season'] as String,
      waterRequirement: (json['waterRequirement'] as num).toDouble(),
      riskScore: (json['riskScore'] as num).toDouble(),
      soilType: json['soilType'] as String,
      benefits: (json['benefits'] as List).cast<String>(),
      challenges: (json['challenges'] as List).cast<String>(),
      marketDemand: (json['marketDemand'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cropName': cropName,
      'cropType': cropType,
      'expectedYield': expectedYield,
      'expectedPrice': expectedPrice,
      'expectedProfit': expectedProfit,
      'growthDuration': growthDuration,
      'season': season,
      'waterRequirement': waterRequirement,
      'riskScore': riskScore,
      'soilType': soilType,
      'benefits': benefits,
      'challenges': challenges,
      'marketDemand': marketDemand,
      'imageUrl': imageUrl,
    };
  }
}
