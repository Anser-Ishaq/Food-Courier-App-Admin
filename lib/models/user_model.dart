import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? role;
  String? phone;
  String? imageURL;
  Timestamp? createAt;
  String? status;
  List<String>? restaurantIDs;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.imageURL,
    this.createAt,
    this.status,
    this.restaurantIDs,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      phone: json['phone'],
      imageURL: json['imageURL'],
      createAt: json['createAt'],
      status: json['status'],
      restaurantIDs: (json['restaurantIDs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['phone'] = phone;
    data['imageURL'] = imageURL;
    data['createAt'] = createAt;
    data['status'] = status;
    data['restaurantIDs'] = restaurantIDs;
    return data;
  }
}
