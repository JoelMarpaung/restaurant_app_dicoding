import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/constants.dart';
import '../custom_widgets/icon_description.dart';
import '../models/restaurant.dart';
import '../ui/data_not_found.dart';
import '../ui/restaurant_detail.dart';
import '../ui/server_error.dart';
import '../apis/restaurant_api_service.dart';
import '../enums/provider_enum.dart';
import '../providers/restaurant_provider.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(
              restaurantApiService: RestaurantApiService(),
            ),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                decoration: const BoxDecoration(color: Colors.blueGrey),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _header(context, state),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state.state == ResultState.loading) ...[
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey.shade500,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Card(
                                    color: Colors.blueGrey.shade50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                              const IconDescription(
                                                  icon:
                                                      Icon(Icons.location_pin),
                                                  description: ''),
                                              const IconDescription(
                                                icon: Icon(Icons.star_rate),
                                                description: '',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ] else if (state.state == ResultState.hasData) ...[
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.listRestaurants.length,
                            itemBuilder: (context, index) {
                              return _buildRestaurantItem(
                                  context, state.listRestaurants[index]);
                            },
                          ),
                        ] else if (state.state == ResultState.noData) ...[
                          DataNotFound(
                            message: state.message,
                          ),
                        ] else if (state.state == ResultState.error) ...[
                          ServerError(
                            message: state.message,
                          ),
                        ] else ...[
                          const Center(
                            child: Material(
                              child: Text(''),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget _header(BuildContext context, RestaurantProvider state) {
    return Container(
      width: double.infinity,
      height: 225,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.blueGrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: TextField(
              onChanged: (value) {
                if (value != '') {
                  state.fetchRestaurants(value);
                } else {
                  state.fetchRestaurants('');
                }
              },
              decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainTitle,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              Text(
                secondaryTitle,
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant.id);
      },
      child: Card(
        color: Colors.blueGrey.shade50,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: CachedNetworkImage(
                  width: 100,
                  imageUrl:
                      urlApi + urlSmallImageRestaurant + restaurant.pictureId,
                  placeholder: (context, url) => const LinearProgressIndicator(
                      backgroundColor: Colors.white, color: Colors.grey),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    IconDescription(
                        icon: const Icon(Icons.location_pin),
                        description: restaurant.city),
                    IconDescription(
                      icon: const Icon(Icons.star_rate),
                      description: restaurant.rating.toString(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
