import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_couriers_admin/services/auth_service.dart';
import 'package:get_it/get_it.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = GetIt.instance.get<AuthService>();
  late final StreamSubscription<User?> _authStateSubscription;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _initializeAuthState();
  }

  void _initializeAuthState() {
    _authStateSubscription = _authService.authStateChanges.listen(_setUser);
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        _setUser(user);
        if (kDebugMode) print('Login successful!');
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      if (kDebugMode) print(_errorMessage);
    } finally {
      _setLoading(false);
    }
    return false;
  }

  void _setUser(User? user) {
    _user = user;
    _isLoading = false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        _errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        _errorMessage = 'Wrong password provided.';
        break;
      case 'weak-password':
        _errorMessage = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        _errorMessage = 'The account already exists for that email.';
        break;
      default:
        _errorMessage = 'Error: ${e.message}';
    }
    if (kDebugMode) print(_errorMessage);
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }
}
