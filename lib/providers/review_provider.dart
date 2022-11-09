import 'dart:async';

import 'package:restaurant_app_dicoding/apis/restaurant_api_service.dart';
import 'package:flutter/material.dart';

import '../enums/provider_enum.dart';
import '../models/customer_review.dart';



class ReviewProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;

  ReviewProvider({required this.restaurantApiService}){
    _stateReview = ResultState.noData;
  }

  late List<CustomerReview> _listReviews;
  late ResultState _stateReview;
  String _message = '';

  String get message => _message;

  List<CustomerReview> get listReviews => _listReviews;

  ResultState get stateReview => _stateReview;

  Future<dynamic> createReview(String id, String name, String review) async {
    try {
      _stateReview = ResultState.loading;
      notifyListeners();
      List<CustomerReview> reviews = await restaurantApiService.createReview(id, name, review);

      if (reviews.isEmpty) {
        _stateReview = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _stateReview = ResultState.hasData;
        notifyListeners();
        return _listReviews = reviews;
      }
    } catch (e) {
      _stateReview = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void notifyConsumer(){
    notifyListeners();
  }
}