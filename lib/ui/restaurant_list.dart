import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app_dicoding/constants/constants.dart';
import 'package:restaurant_app_dicoding/custom_widgets/icon_description.dart';
import 'package:restaurant_app_dicoding/models/restaurant.dart';
import 'package:restaurant_app_dicoding/ui/restaurant_detail.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.blueGrey),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                FutureBuilder<String>(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/local_restaurant.json'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Restaurant> restaurants =
                          parseRestaurants(snapshot.data);
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          return _buildRestaurantItem(
                              context, restaurants[index]);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return AlertDialog(
                        title: Text(
                          "Error !!!",
                          style: GoogleFonts.adventPro(
                            textStyle: Theme.of(context).textTheme.headline3,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.redAccent,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.blueGrey),
      child: Column(
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
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
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
                  imageUrl: restaurant.pictureId,
                  placeholder: (context, url) => const LinearProgressIndicator(
                      backgroundColor: Colors.white, color: Colors.grey),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 20),
              Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
