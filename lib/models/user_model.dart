import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? role;
  final String? phone;
  final String? imageURL;
  final Timestamp? createAt;
  final String? status;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.imageURL,
    this.createAt,
    this.status,
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
    return data;
  }
}
