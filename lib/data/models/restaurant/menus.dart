import 'package:canting_app/data/models/restaurant/drink.dart';
import 'package:canting_app/data/models/restaurant/food.dart';

class Menus {
  // sengaja dipisah class food and drink. padahal bisa dibuat menuItem dan panggil itu.
  // tujuan biar lebih rapi aja.
  // Ex: List<MenuItem> foods;
  List<Food> foods;
  List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}
