import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import '../apis/restaurant_api_service.dart';
import '../enums/provider_enum.dart';
import '../models/customer_review.dart';

class ReviewProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;

  ReviewProvider({required this.restaurantApiService}) {
    stateReview = ResultState.noData;
  }

  late List<CustomerReview> _listReviews;
  late ResultState stateReview;
  String _message = '';

  String get message => _message;

  List<CustomerReview> get listReviews => _listReviews;

  Future<dynamic> createReview(String id, String name, String review) async {
    try {
      stateReview = ResultState.loading;
      notifyListeners();
      List<CustomerReview> reviews =
          await restaurantApiService.createReview(id, name, review);

      if (reviews.isEmpty) {
        stateReview = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        stateReview = ResultState.hasData;
        notifyListeners();
        return _listReviews = reviews;
      }
    } on SocketException catch (e) {
      stateReview = ResultState.error;
      notifyListeners();
      return _message = 'Error --> No Connection found';
    } catch (e) {
      stateReview = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void notifyConsumer() {
    notifyListeners();
  }
}
