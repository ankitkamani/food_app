// To parse this JSON data, do
//
//     final foodModal = foodModalFromJson(jsonString);

import 'dart:convert';

FoodModal foodModalFromJson(String str) => FoodModal.fromJson(json.decode(str));

String foodModalToJson(FoodModal data) => json.encode(data.toJson());

class FoodModal {
  String? restaurant;
  List<Food>? foods;

  FoodModal({
    this.restaurant,
    this.foods,
  });

  factory FoodModal.fromJson(Map<String, dynamic> json) => FoodModal(
    restaurant: json["restaurant"],
    foods: json["foods"] == null ? [] : List<Food>.from(json["foods"]!.map((x) => Food.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurant": restaurant,
    "foods": foods == null ? [] : List<dynamic>.from(foods!.map((x) => x.toJson())),
  };
}

class Food {
  String? name;
  String? type;
  String? description;
  List<Option>? toppings;
  List<Option>? options;
  List<Size>? sizes;
  bool? inStock;
  bool? isVegetarian;
  String? img;
  int? id;

  Food({
    this.name,
    this.type,
    this.description,
    this.toppings,
    this.options,
    this.sizes,
    this.inStock,
    this.isVegetarian,
    this.img,
    this.id,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    name: json["name"],
    type: json["type"],
    description: json["description"],
    toppings: json["toppings"] == null ? [] : List<Option>.from(json["toppings"]!.map((x) => Option.fromJson(x))),
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    sizes: json["sizes"] == null ? [] : List<Size>.from(json["sizes"]!.map((x) => Size.fromJson(x))),
    inStock: json["in_stock"],
    isVegetarian: json["isVegetarian"],
    img: json["img"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "description": description,
    "toppings": toppings == null ? [] : List<dynamic>.from(toppings!.map((x) => x.toJson())),
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x.toJson())),
    "in_stock": inStock,
    "isVegetarian": isVegetarian,
    "img": img,
    "id": id,
  };
}

class Option {
  String? name;
  double? price;
  double? discountedPrice;

  Option({
    this.name,
    this.price,
    this.discountedPrice,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    name: json["name"],
    price: json["price"]?.toDouble(),
    discountedPrice: json["discounted_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "discounted_price": discountedPrice,
  };
}

class Size {
  String? name;
  double? originalPrice;
  double? discountedPrice;

  Size({
    this.name,
    this.originalPrice,
    this.discountedPrice,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    name: json["name"],
    originalPrice: json["original_price"]?.toDouble(),
    discountedPrice: json["discounted_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "original_price": originalPrice,
    "discounted_price": discountedPrice,
  };
}
