import 'dart:async';

import 'package:restaurant_app_dicoding/apis/restaurant_api_service.dart';
import 'package:restaurant_app_dicoding/models/restaurant.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;

  RestaurantProvider({required this.restaurantApiService}) {
      fetchRestaurants('');
  }

  late List<Restaurant> _listRestaurants;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<Restaurant> get listRestaurants => _listRestaurants;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      List<Restaurant> restaurants;
      if(query == ''){
        restaurants = await restaurantApiService.listRestaurants();
      }else{
        restaurants = await restaurantApiService.searchRestaurants(query!);
      }

      if (restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurants = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}