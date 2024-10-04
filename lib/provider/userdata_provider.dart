import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/models.dart';
import 'package:food_couriers_admin/services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class UserdataProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;

  late DatabaseService _databaseService;

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  UserdataProvider() {
    _databaseService = _getIt.get<DatabaseService>();
  }

  void getUser(BuildContext context) async {
    _setLoading(true);
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (authProvider.user != null) {
        final user = await _databaseService.getUser(uid: authProvider.user!.uid);

        _setCurrentUser(user);
      }
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createUser(UserModel user) async {
    _setLoading(true);
    try {
      await _databaseService.createUser(user: user);
      _setCurrentUser(user);
      if (kDebugMode) print('User created successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser({String? newPhone}) async {
    _setLoading(true);
    try {
      final authProvider = GetIt.instance.get<AuthProvider>();
      final uid = authProvider.user!.uid;
      await _databaseService.updateUser(uid: uid, newPhone: newPhone);
      final updatedUser = await _databaseService.getUser(uid: uid);
      if (updatedUser != null) _setCurrentUser(updatedUser);
      if (kDebugMode) print('User updated successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteUser() async {
    _setLoading(true);
    try {
      final authProvider = GetIt.instance.get<AuthProvider>();
      final uid = authProvider.user!.uid;
      await _databaseService.deleteUser(uid: uid);
      _setCurrentUser(null);
      if (kDebugMode) print('User deleted successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  void _setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleError(Object error) {
    _errorMessage = 'An error occurred: $error';
    if (kDebugMode) print(_errorMessage);
    notifyListeners();
  }
}
