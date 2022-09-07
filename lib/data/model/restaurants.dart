import 'dart:convert';

String restaurantsResultToJson(RestaurantsResult data) => json.encode(data.toJson());

class RestaurantsResult {
  
    final bool error;
    final String message;
    final int count;
    final List<Restaurant> restaurants;

    RestaurantsResult({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    factory RestaurantsResult.fromJson(Map<String, dynamic> json) => RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from((json["restaurants"] as List)
              .map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class SearchResult {
    SearchResult({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    final bool error;
    final int founded;
    final List<Restaurant> restaurants;

    factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class Restaurant {
    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}