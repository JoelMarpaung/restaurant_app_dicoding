import 'package:flutter/material.dart';
import 'package:restaurant_app_dicoding/models/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.city),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(restaurant.pictureId),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.description),
                  const Divider(color: Colors.grey),
                  Text(
                    restaurant.id,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text('Date: ${restaurant.name}'),
                  const SizedBox(height: 10),
                  Text('Author: ${restaurant.city}'),
                  const Divider(color: Colors.grey),
                  Text(
                    restaurant.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
