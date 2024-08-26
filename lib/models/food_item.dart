class FoodItem {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  double? price;
  double? rating;
  List<String>? categories;
  bool? isAvailable;
  bool? isVegetarian;
  int? preparationTime;
  List<String>? ingredients;
  int? quantity;
  DateTime? addedDate;

  FoodItem({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.price,
    this.rating,
    this.categories,
    this.isAvailable,
    this.isVegetarian,
    this.preparationTime,
    this.ingredients,
    this.quantity,
    this.addedDate,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price']?.toDouble(),
      rating: json['rating']?.toDouble(),
      categories: (json['categories'] as List<dynamic>?)?.map((category) => category as String).toList() ?? [],
      isAvailable: json['isAvailable'],
      isVegetarian: json['isVegetarian'],
      preparationTime: json['preparationTime'],
      ingredients: (json['ingredients'] as List<dynamic>?)?.map((ingredient) => ingredient as String).toList() ?? [],
      quantity: json['quantity'],
      addedDate: json['addedDate'] != null ? DateTime.parse(json['addedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    data['rating'] = rating;
    data['categories'] = categories;
    data['isAvailable'] = isAvailable;
    data['isVegetarian'] = isVegetarian;
    data['preparationTime'] = preparationTime;
    data['ingredients'] = ingredients;
    data['quantity'] = quantity;
    if (addedDate != null) {
      data['addedDate'] = addedDate!.toIso8601String();
    }
    return data;
  }
}
