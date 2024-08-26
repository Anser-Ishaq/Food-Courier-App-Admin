class Restaurant {
  String? rid;
  String? name;
  String? location;
  String? logo;
  String? ownerName;
  String? ownerEmail;
  String? ownerPhone;
  DateTime? creationDate;
  String? status;

  Restaurant({
    this.rid,
    this.name,
    this.location,
    this.logo,
    this.ownerName,
    this.ownerEmail,
    this.ownerPhone,
    this.creationDate,
    this.status,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      rid: json['rid'],
      name: json['name'],
      location: json['location'],
      logo: json['logo'],
      ownerName: json['ownerName'],
      ownerEmail: json['ownerEmail'],
      ownerPhone: json['ownerPhone'],
      creationDate: json['creationDate'] != null ? DateTime.parse(json['creationDate']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rid'] = rid;
    data['name'] = name;
    data['location'] = location;
    data['logo'] = logo;
    data['ownerName'] = ownerName;
    data['ownerEmail'] = ownerEmail;
    data['ownerPhone'] = ownerPhone;
    if (creationDate != null) {
      data['creationDate'] = creationDate!.toIso8601String();
    }
    data['status'] = status;
    return data;
  }
}
