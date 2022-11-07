import 'dart:convert';
import 'package:restaurant_app_dicoding/models/category.dart';
import 'package:restaurant_app_dicoding/models/customer_review.dart';
import 'package:restaurant_app_dicoding/models/menu.dart';

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.pictureId,
    required this.rating,
    this.address,
    this.categories,
    this.menus,
    this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String pictureId;
  final double rating;
  final String? address;
  final List<Category>? categories;
  final Menu? menus;
  final List<CustomerReview>? customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    pictureId: json["pictureId"],
    rating: json["rating"].toDouble(),
    address: json["address"],
    categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    menus: json["menus"] == null ? null : Menu.fromJson(json["menus"]),
    customerReviews: json["customerReviews"] == null ? null : List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
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
