class CropDiseaseModel {
  final String id;
  final String cropName;
  final String diseaseName;
  final double confidence;
  final String severity; // low, medium, high
  final String description;
  final List<String> symptoms;
  final List<String> treatments;
  final String? imageUrl;
  final DateTime detectedAt;

  CropDiseaseModel({
    required this.id,
    required this.cropName,
    required this.diseaseName,
    required this.confidence,
    required this.severity,
    required this.description,
    required this.symptoms,
    required this.treatments,
    this.imageUrl,
    required this.detectedAt,
  });

  factory CropDiseaseModel.fromJson(Map<String, dynamic> json) {
    return CropDiseaseModel(
      id: json['id'] as String,
      cropName: json['cropName'] as String,
      diseaseName: json['diseaseName'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      severity: json['severity'] as String,
      description: json['description'] as String,
      symptoms: (json['symptoms'] as List).cast<String>(),
      treatments: (json['treatments'] as List).cast<String>(),
      imageUrl: json['imageUrl'] as String?,
      detectedAt: DateTime.parse(json['detectedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cropName': cropName,
      'diseaseName': diseaseName,
      'confidence': confidence,
      'severity': severity,
      'description': description,
      'symptoms': symptoms,
      'treatments': treatments,
      'imageUrl': imageUrl,
      'detectedAt': detectedAt.toIso8601String(),
    };
  }
}
