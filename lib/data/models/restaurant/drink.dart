class Drink {
  String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) =>
      Drink(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
