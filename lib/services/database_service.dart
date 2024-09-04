import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_couriers_admin/models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference _usersCollection;

  DatabaseService() {
    _setupCollectionReferences();
  }

  void _setupCollectionReferences() {
    _usersCollection =
        _firebaseFirestore.collection('users').withConverter<UserModel>(
              fromFirestore: (snapshots, _) =>
                  UserModel.fromJson(snapshots.data()!),
              toFirestore: (users, _) => users.toJson(),
            );
  }

  Future<void> createUser({required UserModel user}) {
    return _usersCollection.doc(user.uid).set(user);
  }

  Future<UserModel?> getUser({required String uid}) async {
    try {
      final DocumentSnapshot<UserModel> documentSnapshot =
          await _usersCollection.doc(uid).get() as DocumentSnapshot<UserModel>;

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
  }) async {
    try {
      Map<String, dynamic> data = {};
      if (newPhone != null) data['phone'] = newPhone;

      await _usersCollection.doc(uid).update(data);
    } catch (e) {
      if (kDebugMode) print("Error updating user: $e");
    }
  }

  Future<void> deleteUser({
    required String uid,
  }) async {
    try {
      await _usersCollection.doc(uid).delete();
    } catch (e) {
      if (kDebugMode) print("Error deleting user: $e");
    }
  }


  Future<List<UserModel>> getAdmins() async {
    try {
      final QuerySnapshot<UserModel> querySnapshot = await _usersCollection
          .where('role', isEqualTo: 'Admin')
          .get() as QuerySnapshot<UserModel>;

      List<UserModel> adminUsers = querySnapshot.docs
          .map((doc) => doc.data())
          .toList();

      return adminUsers;
    } catch (e) {
      if (kDebugMode) print("Error fetching admins: $e");
      return [];
    }
  }
}
