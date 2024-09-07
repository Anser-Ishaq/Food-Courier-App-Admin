import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String? rid;
  String? name;
  String? description;
  String? address;
  String? minOrder;
  String? phoneISOCode;
  String? phone;
  String? whatsappNumberISOCode;
  String? whatsappNumber;
  String? percentFee;
  String? staticFee;
  String? logo;
  String? oid;
  String? ownerName;
  String? ownerEmail;
  String? ownerPhoneISOCode;
  String? ownerPhone;
  Timestamp? creationDate;
  bool active;

  Restaurant({
    this.rid,
    this.name,
    this.description,
    this.address,
    this.minOrder,
    this.phoneISOCode,
    this.phone,
    this.whatsappNumberISOCode,
    this.whatsappNumber,
    this.percentFee,
    this.staticFee,
    this.logo,
    this.oid,
    this.ownerName,
    this.ownerEmail,
    this.ownerPhoneISOCode,
    this.ownerPhone,
    this.creationDate,
    this.active = true,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      rid: json['rid'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      minOrder: json['minOrder'],
      phoneISOCode: json['phoneISOCode'],
      phone: json['phone'],
      whatsappNumberISOCode: json['whatsappNumberISOCode'],
      whatsappNumber: json['whatsappNumber'],
      percentFee: json['percentFee'],
      staticFee: json['staticFee'],
      logo: json['logo'],
      oid: json['oid'],
      ownerName: json['ownerName'],
      ownerEmail: json['ownerEmail'],
      ownerPhoneISOCode: json['ownerPhoneISOCode'],
      ownerPhone: json['ownerPhone'],
      creationDate: json['creationDate'],
      active: json['active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rid'] = rid;
    data['name'] = name;
    data['description'] = description;
    data['address'] = address;
    data['minOrder'] = minOrder;
    data['phoneISOCode'] = phoneISOCode;
    data['phone'] = phone;
    data['whatsappNumberISOCode'] = whatsappNumberISOCode;
    data['whatsappNumber'] = whatsappNumber;
    data['percentFee'] = percentFee;
    data['staticFee'] = staticFee;
    data['logo'] = logo;
    data['oid'] = oid;
    data['ownerName'] = ownerName;
    data['ownerEmail'] = ownerEmail;
    data['ownerPhoneISOCode'] = ownerPhoneISOCode;
    data['ownerPhone'] = ownerPhone;
    if (creationDate != null) {
      data['creationDate'] = creationDate;
    }
    data['active'] = active;
    return data;
  }

  Restaurant copyWith({
    String? rid,
    String? name,
    String? address,
    String? logo,
    String? oid,
    String? ownerName,
    String? ownerEmail,
    String? ownerPhone,
    Timestamp? creationDate,
    bool? active,
  }) {
    return Restaurant(
      rid: rid ?? this.rid,
      name: name ?? this.name,
      address: address ?? this.address,
      logo: logo ?? this.logo,
      oid: oid ?? this.oid,
      ownerName: ownerName ?? this.ownerName,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      creationDate: creationDate ?? this.creationDate,
      active: active ?? this.active,
    );
  }
}
