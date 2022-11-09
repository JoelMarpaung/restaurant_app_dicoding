import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_dicoding/constants/constants.dart';
import 'package:restaurant_app_dicoding/custom_widgets/custom_alert.dart';
import 'package:restaurant_app_dicoding/custom_widgets/icon_description.dart';
import 'package:restaurant_app_dicoding/custom_widgets/list_menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant_app_dicoding/models/customer_review.dart';

import '../enums/alert_enum.dart';
import '../enums/provider_enum.dart';
import '../providers/restaurant_provider.dart';
import '../apis/restaurant_api_service.dart';
import '../providers/review_provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _nameController;
  late TextEditingController _reviewController;

  bool _isFilledText(String text) {
    if (text != "") {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _nameController = TextEditingController();
    _reviewController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _nameController.dispose();
    _reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(
        restaurantApiService: RestaurantApiService(),
        id: widget.id,
      ),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(color: Colors.blueGrey),
              child: SafeArea(
                child: getDetail(context, state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getDetail(BuildContext context, RestaurantProvider state) {
    if (state.state == ResultState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.state == ResultState.hasData) {
      return NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: state.restaurant.pictureId,
                  child: CachedNetworkImage(
                    width: 100,
                    imageUrl: urlApi +
                        urlMediumImageRestaurant +
                        state.restaurant.pictureId,
                    placeholder: (context, url) =>
                        const LinearProgressIndicator(
                            backgroundColor: Colors.white, color: Colors.grey),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.restaurant.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: Colors.blueGrey.shade800,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: 'Desc.',
                  ),
                  Tab(
                    text: 'Reviews',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _description(state),
                  _reviews(state),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (state.state == ResultState.noData) {
      return Center(
        child: Material(
          child: Text(state.message),
        ),
      );
    } else if (state.state == ResultState.error) {
      return Center(
        child: Material(
          child: Text(state.message),
        ),
      );
    } else {
      return const Center(
        child: Material(
          child: Text(''),
        ),
      );
    }
  }

  Widget _description(RestaurantProvider state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconDescription(
                          icon: const Icon(Icons.location_pin),
                          description: state.restaurant.city),
                      IconDescription(
                        icon: const Icon(Icons.star_rate),
                        description: state.restaurant.rating.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    state.restaurant.address!,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    state.restaurant.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ListMenu(title: categoriesTitle, items: state.restaurant.categories!),
          const SizedBox(height: 10),
          ListMenu(title: foodsTitle, items: state.restaurant.menus!.foods),
          const SizedBox(height: 10),
          ListMenu(title: drinksTitle, items: state.restaurant.menus!.drinks),
        ],
      ),
    );
  }

  Widget _reviews(RestaurantProvider state) {
    void showAlert(BuildContext context) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const CustomAlert(title: successAlert, content: reviewSubmitted, status: AlertEnum.success);
          });
    }

    return ChangeNotifierProvider<ReviewProvider>(
      create: (_) => ReviewProvider(
        restaurantApiService: RestaurantApiService(),
      ),
      child: Consumer<ReviewProvider>(
        builder: (context, stateReview, _) {
          Future.delayed(
            Duration.zero,
            () {
              if (stateReview.stateReview == ResultState.hasData) {
                showAlert(context);
              }
            },
          );
          return SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formReviewTitle,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Input your name here...',
                            labelText: 'Your name',
                          ),
                        ),
                        const SizedBox(width: 5),
                        TextField(
                          maxLines: 4,
                          controller: _reviewController,
                          decoration: const InputDecoration(
                            hintText: 'Input your review here...',
                            labelText: 'Your review',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_isFilledText(_nameController.text) &&
                                _isFilledText(_reviewController.text)) {
                              // stateReview.createReview(widget.id,
                              //     _nameController.text, _reviewController.text);
                              showAlert(context);
                            } else if (!_isFilledText(_nameController.text)) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Error !!!",
                                    ),
                                    content: Text(
                                      "Please input your name first",
                                    ),
                                  );
                                },
                              );
                            } else if (!_isFilledText(_reviewController.text)) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Error !!!",
                                    ),
                                    content: Text(
                                      "Please input your review first",
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listReviewTitle,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              stateReview.stateReview == ResultState.hasData
                                  ? stateReview.listReviews.length
                                  : state.restaurant.customerReviews!.length,
                          itemBuilder: (context, index) {
                            return _buildReviewItem(
                                context,
                                stateReview.stateReview == ResultState.hasData
                                    ? stateReview.listReviews[index]
                                    : state.restaurant.customerReviews![index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, CustomerReview customerReview) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Nama    : '),
            Text(customerReview.name),
          ],
        ),
        Row(
          children: [
            const Text('Tanggal : '),
            Text(customerReview.date),
          ],
        ),
        Row(
          children: [
            const Text('Review  : '),
            Expanded(
              child: Text(customerReview.review),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
