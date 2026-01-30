import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  final Box _usersBox = Hive.box('users');

  AuthProvider() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final userId = _usersBox.get('currentUserId');
    if (userId != null) {
      final userData = _usersBox.get(userId);
      if (userData != null) {
        _currentUser = UserModel.fromJson(Map<String, dynamic>.from(userData));
        notifyListeners();
      }
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Demo user - In production, this would call actual auth API
      if (email == 'farmer@agrisense.com' || email.contains('demo')) {
        final user = UserModel(
          id: 'user_001',
          name: 'Ravi Kumar',
          email: email,
          phone: '+91 9876543210',
          role: 'farmer',
          createdAt: DateTime.now(),
          isVerified: true,
          metadata: {
            'location': 'Karnataka, India',
            'farmCount': 2,
          },
        );

        await _usersBox.put(user.id, user.toJson());
        await _usersBox.put('currentUserId', user.id);
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid credentials';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String role,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        phone: phone,
        role: role,
        createdAt: DateTime.now(),
        isVerified: false,
      );

      await _usersBox.put(user.id, user.toJson());
      await _usersBox.put('currentUserId', user.id);
      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Registration failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _usersBox.delete('currentUserId');
    _currentUser = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
