import 'package:flutter/material.dart';
import '../models/favourite.dart';
import '../providers/favourite_provider.dart';

class FavouriteWidget extends StatelessWidget {
  final FavouriteProvider provider;
  final bool isFavourite;
  final String id;
  const FavouriteWidget(
      {Key? key,
      required this.isFavourite,
      required this.provider,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isFavourite) {
          provider.deleteFavourite(id);
        } else {
          Favourite favourite = Favourite(id: id);
          await provider.addFavourite(favourite);
        }
      },
      child: Center(
        child: iconFovourite(isFavourite),
      ),
    );
  }
}

Widget iconFovourite(bool isFavourite) {
  if (!isFavourite) {
    return const Icon(Icons.favorite_outline);
  } else {
    return const Icon(Icons.favorite);
  }
}
