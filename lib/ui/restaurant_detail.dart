import 'package:flutter/material.dart';
import 'package:restaurant_app_dicoding/constants/constants.dart';
import 'package:restaurant_app_dicoding/custom_widgets/icon_description.dart';
import 'package:restaurant_app_dicoding/custom_widgets/list_menu.dart';
import 'package:restaurant_app_dicoding/models/restaurant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.blueGrey),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: restaurant.pictureId,
                      child: CachedNetworkImage(
                        width: 100,
                        imageUrl: restaurant.pictureId,
                        placeholder: (context, url) =>
                            const LinearProgressIndicator(
                                backgroundColor: Colors.white,
                                color: Colors.grey),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconDescription(
                                  icon: const Icon(Icons.location_pin),
                                  description: restaurant.city),
                              IconDescription(
                                icon: const Icon(Icons.star_rate),
                                description: restaurant.rating.toString(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            restaurant.description,
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListMenu(title: foodsTitle, items: restaurant.menus!.foods),
                  const SizedBox(height: 10),
                  ListMenu(title: drinksTitle, items: restaurant.menus!.drinks),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
