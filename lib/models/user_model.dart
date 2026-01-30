// part 'user_model.g.dart';  // Commented out - not using Hive type adapters

// @HiveType(typeId: 0)
class UserModel {
  // @HiveField(0)
  final String id;

  // @HiveField(1)
  final String name;

  // @HiveField(2)
  final String email;

  // @HiveField(3)
  final String phone;

  // @HiveField(4)
  final String role; // farmer, buyer, admin, government

  // @HiveField(5)
  final String? profileImage;

  // @HiveField(6)
  final DateTime createdAt;

  // @HiveField(7)
  final bool isVerified;

  // @HiveField(8)
  final Map<String, dynamic>? metadata;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImage,
    required this.createdAt,
    this.isVerified = false,
    this.metadata,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      profileImage: json['profileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isVerified: json['isVerified'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      'isVerified': isVerified,
      'metadata': metadata,
    };
  }
}
