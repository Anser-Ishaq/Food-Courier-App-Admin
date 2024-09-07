import 'package:flutter/foundation.dart';
import 'package:food_couriers_admin/models/user_model.dart';
import 'package:food_couriers_admin/services/database_service.dart';
import 'package:get_it/get_it.dart';

class OwnerdataProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;

  late DatabaseService _databaseService;

  UserModel? _currentOwner;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentOwner => _currentOwner;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  OwnerdataProvider() {
    _databaseService = _getIt.get<DatabaseService>();
  }

  void getOwner(String uid) async {
    _setLoading(true);
    try {
      final owner = await _databaseService.getUser(uid: uid);

      _setCurrentOwner(owner);
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<UserModel?> getOwnerByEmail(String email) async {
    _setLoading(true);
    try {
      final owner = await _databaseService.getUserByEmail(email);
      return owner;
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
    return null;
  }

  Future<String> createOwner(UserModel owner) async {
    _setLoading(true);
    try {
      final result = await _databaseService.createUser(user: owner);
      if (kDebugMode) print('Owner created successfully!');
      return result;
    } catch (e) {
      _handleError(e);
      return '';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateOwner({
    required String uid,
    String? newName,
    String? newEmail,
    String? newPhone,
    String? newRestaurantID,
    String? existingRestaurantID,
  }) async {
    _setLoading(true);
    try {
      await _databaseService.updateUser(
        uid: uid,
        newName: newName,
        newEmail: newEmail,
        newPhone: newPhone,
        newRestaurantID: newRestaurantID,
        existingRestaurantID: existingRestaurantID,
      );
      final updatedOwner = await _databaseService.getUser(uid: uid);
      if (updatedOwner != null) _setCurrentOwner(updatedOwner);
      if (kDebugMode) print('Owner updated successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteOwner(String uid) async {
    _setLoading(true);
    try {
      await _databaseService.deleteUser(uid: uid);
      _setCurrentOwner(null);
      if (kDebugMode) print('Owner deleted successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  void _setCurrentOwner(UserModel? owner) {
    _currentOwner = owner;
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
