// To parse this JSON data, do
//
//     final orderDataModal = orderDataModalFromJson(jsonString);

import 'dart:convert';

OrderDataModal orderDataModalFromJson(String str) => OrderDataModal.fromJson(json.decode(str));

String orderDataModalToJson(OrderDataModal data) => json.encode(data.toJson());

class OrderDataModal {
  Food food;
  int totalQuantity;
  int id;

  OrderDataModal({
    required this.food,
    required this.totalQuantity,
    required this.id,
  });

  factory OrderDataModal.fromJson(Map<String, dynamic> json) => OrderDataModal(
    food: Food.fromJson(json["food"]),
    totalQuantity: json["totalQuantity"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "food": food.toJson(),
    "totalQuantity": totalQuantity,
    "id": id,
  };
}

class Food {
  String name;
  List<Options> toppings;
  Options options;
  Sizes sizes;
  bool inStock;
  bool isVegetarian;
  String img;

  Food({
    required this.name,
    required this.toppings,
    required this.options,
    required this.sizes,
    required this.inStock,
    required this.isVegetarian,
    required this.img,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    name: json["name"],
    toppings: List<Options>.from(json["toppings"].map((x) => Options.fromJson(x))),
    options: Options.fromJson(json["options"]),
    sizes: Sizes.fromJson(json["sizes"]),
    inStock: json["in_stock"],
    isVegetarian: json["isVegetarian"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
    "options": options.toJson(),
    "sizes": sizes.toJson(),
    "in_stock": inStock,
    "isVegetarian": isVegetarian,
    "img": img,
  };
}

class Options {
  String name;
  double price;
  double discountedPrice;

  Options({
    required this.name,
    required this.price,
    required this.discountedPrice,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
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

class Sizes {
  String name;
  double originalPrice;
  double discountedPrice;

  Sizes({
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
  });

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
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
