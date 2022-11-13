import 'dart:math';
import 'dart:ui';
import 'dart:isolate';

import '../apis/restaurant_api_service.dart';
import '../main.dart';
import '../models/restaurant.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    final RestaurantApiService restaurantApiService = RestaurantApiService();
    List<Restaurant> restaurants = await restaurantApiService.listRestaurants();
    final random = Random();
    var randomNumber = random.nextInt(restaurants.length);
    var resto = restaurants[randomNumber];
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, resto);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
