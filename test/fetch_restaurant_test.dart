import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app_dicoding/apis/restaurant_api_service.dart';
import 'package:restaurant_app_dicoding/models/restaurant.dart';

import 'fetch_restaurant_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchRestaurant', () {
    test('returns list of Restaurant if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list'))).thenAnswer(
              (_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}', 200));
      RestaurantApiService api = RestaurantApiService(client);
      expect(await api.listRestaurants(), isA<List<Restaurant>>());
    });

    test('returns a Restaurant if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      String json = '''{
          "restaurant": {
            "id": "",
            "name": "",
            "description": "",
            "city": "",
            "address": "",
            "pictureId": "",
            "categories": [],
            "menus": {
                "foods": [],
                "drinks": []
            },
            "rating": 0,
            "customerReviews": []
          }
        }
      ''';
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867')))
          .thenAnswer((_) async =>
          http.Response(json, 200));
      RestaurantApiService api = RestaurantApiService(client);

      expect(await api.detailRestaurant('rqdv5juczeskfw1e867'), isA<Restaurant>());
    });

  });
}