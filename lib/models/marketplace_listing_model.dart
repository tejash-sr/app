class MarketplaceListingModel {
  final String id;
  final String sellerId;
  final String sellerName;
  final String cropName;
  final String cropType;
  final double quantity; // in kg
  final double pricePerKg;
  final String quality; // premium, good, average
  final String location;
  final List<String> images;
  final String description;
  final DateTime harvestDate;
  final DateTime listedAt;
  final String status; // available, sold, reserved
  final List<BidModel> bids;
  final double? rating;

  MarketplaceListingModel({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.cropName,
    required this.cropType,
    required this.quantity,
    required this.pricePerKg,
    required this.quality,
    required this.location,
    required this.images,
    required this.description,
    required this.harvestDate,
    required this.listedAt,
    required this.status,
    this.bids = const [],
    this.rating,
  });

  factory MarketplaceListingModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceListingModel(
      id: json['id'] as String,
      sellerId: json['sellerId'] as String,
      sellerName: json['sellerName'] as String,
      cropName: json['cropName'] as String,
      cropType: json['cropType'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      pricePerKg: (json['pricePerKg'] as num).toDouble(),
      quality: json['quality'] as String,
      location: json['location'] as String,
      images: (json['images'] as List).cast<String>(),
      description: json['description'] as String,
      harvestDate: DateTime.parse(json['harvestDate'] as String),
      listedAt: DateTime.parse(json['listedAt'] as String),
      status: json['status'] as String,
      bids: (json['bids'] as List?)
              ?.map((e) => BidModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'cropName': cropName,
      'cropType': cropType,
      'quantity': quantity,
      'pricePerKg': pricePerKg,
      'quality': quality,
      'location': location,
      'images': images,
      'description': description,
      'harvestDate': harvestDate.toIso8601String(),
      'listedAt': listedAt.toIso8601String(),
      'status': status,
      'bids': bids.map((e) => e.toJson()).toList(),
      'rating': rating,
    };
  }
}

class BidModel {
  final String id;
  final String buyerId;
  final String buyerName;
  final double bidPrice;
  final double quantity;
  final DateTime bidAt;
  final String status; // pending, accepted, rejected

  BidModel({
    required this.id,
    required this.buyerId,
    required this.buyerName,
    required this.bidPrice,
    required this.quantity,
    required this.bidAt,
    required this.status,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['id'] as String,
      buyerId: json['buyerId'] as String,
      buyerName: json['buyerName'] as String,
      bidPrice: (json['bidPrice'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      bidAt: DateTime.parse(json['bidAt'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'bidPrice': bidPrice,
      'quantity': quantity,
      'bidAt': bidAt.toIso8601String(),
      'status': status,
    };
  }
}
