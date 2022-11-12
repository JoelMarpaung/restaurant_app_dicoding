import 'package:flutter/foundation.dart';

import '../database/database_helper.dart';
import '../models/favourite.dart';

class FavouriteProvider extends ChangeNotifier {
  late Favourite? _favourite;
  late DatabaseHelper _dbHelper;

  Favourite? get favourite => _favourite;

  FavouriteProvider() {
    _dbHelper = DatabaseHelper();
  }

  Future<void> addFavourite(Favourite favourite) async {
    await _dbHelper.insertFavourite(favourite);
    notifyListeners();
  }

  Future<bool> isFavourite(String id) async {
    final favourite = await _dbHelper.getFavouriteById(id);
    return favourite.isNotEmpty;
  }

  void deleteFavourite(String id) async {
    await _dbHelper.deleteFavourite(id);
    notifyListeners();
  }
}
