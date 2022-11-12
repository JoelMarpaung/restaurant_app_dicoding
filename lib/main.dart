import 'package:flutter/material.dart';
import 'package:restaurant_app_dicoding/themes/text_theme.dart';
import 'package:restaurant_app_dicoding/ui/homepage.dart';
import 'package:restaurant_app_dicoding/ui/restaurant_detail.dart';
import 'package:restaurant_app_dicoding/ui/restaurant_list.dart';
import 'package:restaurant_app_dicoding/ui/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        textTheme: myTextTheme,
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.routeName,//SplashScreen.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
