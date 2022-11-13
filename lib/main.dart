import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_dicoding/database/preferences_helper.dart';
import 'package:restaurant_app_dicoding/providers/favourite_provider.dart';
import 'package:restaurant_app_dicoding/providers/restaurant_provider.dart';
import 'package:restaurant_app_dicoding/providers/review_provider.dart';
import 'package:restaurant_app_dicoding/providers/setting_provider.dart';
import 'package:restaurant_app_dicoding/themes/text_theme.dart';
import 'package:restaurant_app_dicoding/ui/homepage.dart';
import 'package:restaurant_app_dicoding/ui/restaurant_detail.dart';
import 'package:restaurant_app_dicoding/ui/restaurant_list.dart';
import 'package:restaurant_app_dicoding/ui/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/restaurant_api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(
            restaurantApiService: RestaurantApiService(),
          ),
        ),
        ChangeNotifierProvider<ReviewProvider>(
          create: (_) => ReviewProvider(
            restaurantApiService: RestaurantApiService(),
          ),
        ),
        ChangeNotifierProvider<FavouriteProvider>(
          create: (_) => FavouriteProvider(),
        ),
        ChangeNotifierProvider<SettingProvider>(
          create: (_) => SettingProvider(
              preferencesHelper: PreferencesHelper(
                  preference: SharedPreferences.getInstance())),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          textTheme: myTextTheme,
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomePage.routeName, //SplashScreen.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SplashScreen.routeName: (context) => const SplashScreen(),
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
        },
      ),
    );
  }
}
