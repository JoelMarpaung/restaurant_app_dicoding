import 'package:flutter/material.dart';
import 'package:restaurant_app_dicoding/constants/constants.dart';
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
                    title: Text(restaurant.name,
                        style: Theme.of(context).textTheme.headline6),
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
                              Row(
                                children: [
                                  const Icon(Icons.location_pin),
                                  const SizedBox(width: 5),
                                  Text(
                                    restaurant.city,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star_rate),
                                  const SizedBox(width: 5),
                                  Text(
                                    restaurant.rating.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
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
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              foodsTitle,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: restaurant.menus.foods
                                  .map(
                                    (item) => Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade700,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Text(
                                        item.name,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              drinksTitle,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: restaurant.menus.drinks
                                  .map(
                                    (item) => Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade700,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Text(
                                        item.name,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
