import 'package:flutter/foundation.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/services/database_service.dart';
import 'package:get_it/get_it.dart';

class RestaurantProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;

  List<Restaurant>? _restaurants;
  Restaurant? _selectedRestaurant;
  bool _isLoading = false;
  String? _errorMessage;

  List<Restaurant>? get restaurants => _restaurants;
  Restaurant? get selectedRestaurant => _selectedRestaurant;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  RestaurantProvider() {
    _databaseService = _getIt.get<DatabaseService>();
  }

  Future<void> fetchRestaurants() async {
    // _setLoading(true);
    try {
      final List<Restaurant> fetchedRestaurants = await _databaseService.getAllRestaurants();

      _restaurants = fetchedRestaurants;

      notifyListeners();
    } catch (e) {
      _handleError(e);
    } finally {
      // _setLoading(false);
    }
  }

  Future<void> getRestaurantById(String rid) async {
    _setLoading(true);
    try {
      final restaurant = await _databaseService.getRestaurant(rid: rid);
      _selectedRestaurant = restaurant;
      notifyListeners();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<String> createRestaurant(Restaurant restaurant) async {
    _setLoading(true);
    try {
      final result = await _databaseService.createRestaurant(restaurant: restaurant);
      fetchRestaurants();
      if (kDebugMode) print('Restaurant created successfully!');
      return result;
    } catch (e) {
      _handleError(e);
      return '';
    } finally {
      _setLoading(false);
    }

  }

  Future<void> updateRestaurant(Restaurant restaurant) async {
    _setLoading(true);
    try {
      await _databaseService.updateRestaurant(
        rid: restaurant.rid!,
        name: restaurant.name,
        address: restaurant.address,
        logo: restaurant.logo,
        oid: restaurant.oid,
        creationDate: restaurant.creationDate,
        active: restaurant.active,
      );
      fetchRestaurants();
      if (kDebugMode) print('Restaurant updated successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteRestaurant(String rid) async {
    _setLoading(true);
    try {
      await _databaseService.deleteRestaurant(rid: rid);
      fetchRestaurants();
      if (kDebugMode) print('Restaurant deleted successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
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
