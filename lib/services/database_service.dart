import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_couriers_admin/models/shift_model.dart';
import 'package:food_couriers_admin/models/user_model.dart';
import 'package:food_couriers_admin/models/restaurant.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference<UserModel> _usersCollection;
  late CollectionReference<Restaurant> _restaurantsCollection;
  late CollectionReference<ShiftModel> _shiftsCollection;

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
    _shiftsCollection =
        _firebaseFirestore.collection('shifts').withConverter<ShiftModel>(
              fromFirestore: (snapshots, _) =>
                  ShiftModel.fromJson(snapshots.data()!),
              toFirestore: (shift, _) => shift.toJson(),
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

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final QuerySnapshot<UserModel> querySnapshot = await _usersCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        if (kDebugMode) print("User with email $email does not exist.");
        return null;
      }

      return querySnapshot.docs.first.data();
    } catch (e) {
      if (kDebugMode) print("Error getting user by email: $e");
      return null;
    }
  }

  Future<void> updateUser({
    required String uid,
    String? newName,
    String? newEmail,
    String? newPhone,
    String? newRestaurantID,
    String? existingRestaurantID,
  }) async {
    try {
      Map<String, dynamic> data = {};
      if (newName != null) data['name'] = newName;
      if (newEmail != null) data['email'] = newEmail;
      if (newPhone != null) data['phone'] = newPhone;
      if (newRestaurantID != null) {
        data['restaurantIDs'] = FieldValue.arrayUnion([newRestaurantID]);
      }
      if (existingRestaurantID != null) {
        data['restaurantIDs'] = FieldValue.arrayRemove([existingRestaurantID]);
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
    String? description,
    String? address,
    String? logo,
    bool? active,
    String? phoneISOCode,
    String? phone,
    String? percentFee,
    String? staticFee,
    String? minOrder,
    String? whatsappNumberISOCode,
    String? whatsappNumber,
    String? ownerName,
    String? ownerEmail,
    String? ownerPhoneISOCode,
    String? ownerPhone,
    String? shiftID,
  }) async {
    try {
      Map<String, dynamic> data = {};

      if (name != null) data['name'] = name;
      if (description != null) data['description'] = description;
      if (address != null) data['address'] = address;
      if (phoneISOCode != null) data['phoneISOCode'] = phoneISOCode;
      if (phone != null) data['phone'] = phone;
      if (logo != null) data['logo'] = logo;
      if (active != null) data['active'] = active;
      if (percentFee != null) data['percentFee'] = percentFee;
      if (staticFee != null) data['staticFee'] = staticFee;
      if (minOrder != null) data['minOrder'] = minOrder;
      if (whatsappNumberISOCode != null) {
        data['whatsappNumberISOCode'] = whatsappNumberISOCode;
      }
      if (whatsappNumber != null) data['whatsappNumber'] = whatsappNumber;
      if (ownerName != null) data['ownerName'] = ownerName;
      if (ownerEmail != null) data['ownerEmail'] = ownerEmail;
      if (ownerPhoneISOCode != null) {
        data['ownerPhoneISOCode'] = ownerPhoneISOCode;
      }
      if (ownerPhone != null) data['ownerPhone'] = ownerPhone;
      if (shiftID != null) data['shifts'] = FieldValue.arrayUnion([shiftID]);

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

  Future<String> createShift({required ShiftModel shift}) async {
    if (shift.sid != null) {
      await _shiftsCollection.doc(shift.sid).set(shift);
      return shift.sid!;
    }
    final docRef = _shiftsCollection.doc();

    shift.sid = docRef.id;
    await docRef.set(shift);

    return docRef.id;
  }

  Future<ShiftModel?> getShift({required String sid}) async {
    try {
      final DocumentSnapshot<ShiftModel> documentSnapshot =
          await _shiftsCollection.doc(sid).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        if (kDebugMode) {
          print("Shift with document ID $sid does not exist.");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) print("Error getting shift: $e");
      return null;
    }
  }

  Future<void> updateShift({
    required String sid,
    required ShiftModel shift,
  }) async {
    try {
      Map<String, dynamic> data = shift.toJson();

      await _shiftsCollection.doc(sid).update(data);
    } catch (e) {
      if (kDebugMode) print("Error updating shiftt: $e");
    }
  }

  Future<void> deleteShift({required String sid}) async {
    try {
      await _shiftsCollection.doc(sid).delete();
    } catch (e) {
      if (kDebugMode) print("Error deleting shift: $e");
    }
  }

  Future<List<ShiftModel>?> getAllShifts({
    required List<String>? shiftIDs,
  }) async {
    if (shiftIDs == null || shiftIDs.isEmpty) {
      return [];
    }

    try {
      final querySnapshot = await _shiftsCollection
          .where('sid', whereIn: shiftIDs)
          .orderBy('shiftNo')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error getting all shifts: $e");
      }
      return null;
    }
  }
}
