import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_dicoding/constants/constants.dart';
import 'package:restaurant_app_dicoding/models/restaurant.dart';
import 'package:restaurant_app_dicoding/models/customer_review.dart';

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
    final response = await http.get(Uri.parse(urlApi + urlSearchRestaurant + query));
    if (response.statusCode == 200) {
      return parseRestaurants(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }
}