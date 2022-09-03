import 'dart:convert';

class Restaurants {
    Restaurants({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
        required this.menus,
    });

    final String id;
    final String name;
    final String description;
    final String pictureId;
    final String city;
    final double rating;
    final Menus menus;

    factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
    };
}

class Menus {
    Menus({
        required this.foods,
        required this.drinks,
    });

    final List<Drink> foods;
    final List<Drink> drinks;

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}

class Drink {
    Drink({
        required this.name,
    });

    final String name;

    factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

List<Restaurants> restaurantsFromJson(String? str){
  if (str == null) {
    return [];
  }
  var data = json.decode(str);
  var restaurant = data['restaurants'] as List;
  return restaurant.map<Restaurants>((json) => Restaurants.fromJson(json)).toList();
}

String restaurantsToJson(Restaurants data) => json.encode(data.toJson());

