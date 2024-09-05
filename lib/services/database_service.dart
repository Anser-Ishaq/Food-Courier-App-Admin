import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_couriers_admin/models/user_model.dart';
import 'package:food_couriers_admin/models/restaurant.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference<UserModel> _usersCollection;
  late CollectionReference<Restaurant> _restaurantsCollection;

  DatabaseService() {
    _setupCollectionReferences();
  }

  void _setupCollectionReferences() {
    _usersCollection =
        _firebaseFirestore.collection('users').withConverter<UserModel>(
              fromFirestore: (snapshots, _) =>
                  UserModel.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    _restaurantsCollection =
        _firebaseFirestore.collection('restaurants').withConverter<Restaurant>(
              fromFirestore: (snapshots, _) =>
                  Restaurant.fromJson(snapshots.data()!),
              toFirestore: (restaurant, _) => restaurant.toJson(),
            );
  }

  Future<String> createUser({required UserModel user}) async {
    if (user.uid != null) {
      await _usersCollection.doc(user.uid).set(user);
      return user.uid!;
    }
    final docRef = _usersCollection.doc();

    user.uid = docRef.id;
    await docRef.set(user);

    return docRef.id;
  }

  Future<UserModel?> getUser({required String uid}) async {
    try {
      final DocumentSnapshot<UserModel> documentSnapshot =
          await _usersCollection.doc(uid).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        if (kDebugMode) print("User with document ID $uid does not exist.");
        return null;
      }
    } catch (e) {
      if (kDebugMode) print("Error getting user: $e");
      return null;
    }
  }

  Future<void> updateUser({
    required String uid,
    String? newPhone,
    String? newRestaurantID,
  }) async {
    try {
      Map<String, dynamic> data = {};
      if (newPhone != null) data['phone'] = newPhone;
      if (newRestaurantID != null) {
        data['restaurantIDs'] = FieldValue.arrayUnion([newRestaurantID]);
      }

      await _usersCollection.doc(uid).update(data);
    } catch (e) {
      if (kDebugMode) print("Error updating user: $e");
    }
  }

  Future<void> deleteUser({required String uid}) async {
    try {
      await _usersCollection.doc(uid).delete();
    } catch (e) {
      if (kDebugMode) print("Error deleting user: $e");
    }
  }

  Future<String> createRestaurant({required Restaurant restaurant}) async {
    try {
      final docRef = _restaurantsCollection.doc();

      restaurant.rid = docRef.id;
      await docRef.set(restaurant);

      return docRef.id;
    } catch (e) {
      if (kDebugMode) print("Error creating restaurant: $e");
      rethrow;
    }
  }

  Future<Restaurant?> getRestaurant({required String rid}) async {
    try {
      final DocumentSnapshot<Restaurant> documentSnapshot =
          await _restaurantsCollection.doc(rid).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        if (kDebugMode) {
          print("Restaurant with document ID $rid does not exist.");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) print("Error getting restaurant: $e");
      return null;
    }
  }

  Future<void> updateRestaurant({
    required String rid,
    String? name,
    String? address,
    String? logo,
    String? oid,
    Timestamp? creationDate,
    bool? active,
  }) async {
    try {
      Map<String, dynamic> data = {};
      if (name != null) data['name'] = name;
      if (address != null) data['address'] = address;
      if (logo != null) data['logo'] = logo;
      if (oid != null) data['oid'] = oid;
      if (creationDate != null) data['creationDate'] = creationDate;
      if (active != null) data['active'] = active;

      await _restaurantsCollection.doc(rid).update(data);
    } catch (e) {
      if (kDebugMode) print("Error updating restaurant: $e");
    }
  }

  Future<void> deleteRestaurant({required String rid}) async {
    try {
      await _restaurantsCollection.doc(rid).delete();
    } catch (e) {
      if (kDebugMode) print("Error deleting restaurant: $e");
    }
  }

  Future<List<Restaurant>> getAllRestaurants() async {
    try {
      final QuerySnapshot<Restaurant> querySnapshot =
          await _restaurantsCollection.get();

      final restaurants = querySnapshot.docs.map((doc) => doc.data()).toList();
      return restaurants;
    } catch (e) {
      if (kDebugMode) print("Error getting all restaurants: $e");
      return [];
    }
  }
}
