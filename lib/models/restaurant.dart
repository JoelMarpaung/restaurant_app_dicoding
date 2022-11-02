import 'dart:convert';
import 'package:restaurant_app_dicoding/models/menus.dart';

class Restaurant {
  Restaurant({
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

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
      );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }
  var data = jsonDecode(json);
  final List parsed = data['restaurants'] as List;
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
