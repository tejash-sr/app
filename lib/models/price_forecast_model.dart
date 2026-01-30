class PriceForecastModel {
  final String cropName;
  final double currentPrice; // per kg
  final double predictedPrice30Days;
  final double predictedPrice60Days;
  final double predictedPrice90Days;
  final String trend; // rising, falling, stable
  final double confidence; // 0-100
  final String bestSellDate;
  final List<PriceDataPoint> historicalPrices;
  final List<PriceDataPoint> forecastedPrices;
  final String marketAnalysis;
  final DateTime timestamp;

  PriceForecastModel({
    required this.cropName,
    required this.currentPrice,
    required this.predictedPrice30Days,
    required this.predictedPrice60Days,
    required this.predictedPrice90Days,
    required this.trend,
    required this.confidence,
    required this.bestSellDate,
    required this.historicalPrices,
    required this.forecastedPrices,
    required this.marketAnalysis,
    required this.timestamp,
  });

  factory PriceForecastModel.fromJson(Map<String, dynamic> json) {
    return PriceForecastModel(
      cropName: json['cropName'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      predictedPrice30Days: (json['predictedPrice30Days'] as num).toDouble(),
      predictedPrice60Days: (json['predictedPrice60Days'] as num).toDouble(),
      predictedPrice90Days: (json['predictedPrice90Days'] as num).toDouble(),
      trend: json['trend'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      bestSellDate: json['bestSellDate'] as String,
      historicalPrices: (json['historicalPrices'] as List)
          .map((e) => PriceDataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      forecastedPrices: (json['forecastedPrices'] as List)
          .map((e) => PriceDataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      marketAnalysis: json['marketAnalysis'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cropName': cropName,
      'currentPrice': currentPrice,
      'predictedPrice30Days': predictedPrice30Days,
      'predictedPrice60Days': predictedPrice60Days,
      'predictedPrice90Days': predictedPrice90Days,
      'trend': trend,
      'confidence': confidence,
      'bestSellDate': bestSellDate,
      'historicalPrices': historicalPrices.map((e) => e.toJson()).toList(),
      'forecastedPrices': forecastedPrices.map((e) => e.toJson()).toList(),
      'marketAnalysis': marketAnalysis,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class PriceDataPoint {
  final String date;
  final double price;

  PriceDataPoint({
    required this.date,
    required this.price,
  });

  factory PriceDataPoint.fromJson(Map<String, dynamic> json) {
    return PriceDataPoint(
      date: json['date'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'price': price,
    };
  }
}
