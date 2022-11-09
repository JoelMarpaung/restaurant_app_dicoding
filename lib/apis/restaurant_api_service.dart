import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/restaurant.dart';
import '../models/customer_review.dart';

class RestaurantApiService {
  Future<List<Restaurant>> listRestaurants() async {
    final response = await http.get(Uri.parse(urlApi + urlListRestaurant));
    if (response.statusCode == 200) {
      return parseRestaurants(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    final response =
        await http.get(Uri.parse(urlApi + urlSearchRestaurant + query));
    if (response.statusCode == 200) {
      return parseRestaurants(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Restaurant> detailRestaurant(String id) async {
    final response =
        await http.get(Uri.parse(urlApi + urlDetailRestaurant + id));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body)['restaurant']);
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<CustomerReview>> createReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse(urlApi + urlReviewRestaurant),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review,
      }),
    );
    if (response.statusCode == 201) {
      return parseCustomerReviews(response.body);
    } else {
      throw Exception('Failed to create Review.');
    }
  }
}
