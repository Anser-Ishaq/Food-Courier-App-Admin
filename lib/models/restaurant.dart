class Restaurant {
  String? rid;
  String? name;
  String? address;
  String? logo;
  String? ownerName;
  String? ownerEmail;
  String? ownerPhone;
  DateTime? creationDate;
  bool? active;

  Restaurant({
    this.rid,
    this.name,
    this.address,
    this.logo,
    this.ownerName,
    this.ownerEmail,
    this.ownerPhone,
    this.creationDate,
    this.active = true,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      rid: json['rid'],
      name: json['name'],
      address: json['address'],
      logo: json['logo'],
      ownerName: json['ownerName'],
      ownerEmail: json['ownerEmail'],
      ownerPhone: json['ownerPhone'],
      creationDate: json['creationDate'] != null ? DateTime.parse(json['creationDate']) : null,
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rid'] = rid;
    data['name'] = name;
    data['address'] = address;
    data['logo'] = logo;
    data['ownerName'] = ownerName;
    data['ownerEmail'] = ownerEmail;
    data['ownerPhone'] = ownerPhone;
    if (creationDate != null) {
      data['creationDate'] = creationDate!.toIso8601String();
    }
    data['active'] = active;
    return data;
  }
}
