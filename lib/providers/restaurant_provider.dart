import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import '../apis/restaurant_api_service.dart';
import '../models/restaurant.dart';
import '../enums/provider_enum.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;
  String? id;

  RestaurantProvider({required this.restaurantApiService, this.id}) {
    if (id == null) {
      fetchRestaurants('');
    } else {
      detailRestaurant(id!);
    }
  }

  bool _disposed = false;
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  late List<Restaurant> _listRestaurants;
  late Restaurant _restaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<Restaurant> get listRestaurants => _listRestaurants;

  Restaurant get restaurant => _restaurant;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      List<Restaurant> restaurants;
      if (query == '') {
        restaurants = await restaurantApiService.listRestaurants();
      } else {
        restaurants = await restaurantApiService.searchRestaurants(query);
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
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> No Connection found';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> detailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      Restaurant? restaurant = await restaurantApiService.detailRestaurant(id);

      if (restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } on SocketException{
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> No Connection found';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
