import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_couriers_admin/services/auth_service.dart';
import 'package:get_it/get_it.dart';

class AuthProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _rememberMe = false;
  bool _isPasswordVisible = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isPasswordVisible => _isPasswordVisible;
  bool? get rememberMe => _rememberMe;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  AuthProvider() {
    _authService = _getIt.get<AuthService>();
    _initializeAuthState();
    _loadCredentials();
  }

  void _initializeAuthState() async {
    _user = _authService.currentUser;
    _authService.authStateChanges.listen(authStateChangesStreamListener);
  }

  void authStateChangesStreamListener(User? user) async {
    _setUser(user);
  }

  void _setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        _setUser(user);
        if (_rememberMe == true) {
          _saveCredentials(email, password);
        }
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

  Future<void> logout() async {
    await _authService.signOut();
    _setUser(null);
    notifyListeners();
  }

  void _saveCredentials(String email, String password) async {
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'password', value: password);
  }

  Future<void> _loadCredentials() async {
    final email = await _storage.read(key: 'email');
    final password = await _storage.read(key: 'password');
    if (email != null && password != null) {
      _emailController.text = email;
      _passwordController.text = password;
      _rememberMe = true;
    }
    notifyListeners();
  }

  void setRememberMe(bool? value) {
    _rememberMe = value!;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleAuthException(FirebaseAuthException e) {
    _errorMessage = e.message;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
