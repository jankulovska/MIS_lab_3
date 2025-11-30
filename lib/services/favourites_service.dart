import 'package:flutter/foundation.dart';
import '../models/meal.dart';

class FavoriteService extends ChangeNotifier {
  final Map<String, MealSummary> _favorites = {};

  List<MealSummary> get favorites => _favorites.values.toList();

  bool isFavorite(String id) {
    return _favorites.containsKey(id);
  }

  void toggleFavorite(MealSummary meal) {
    if (_favorites.containsKey(meal.idMeal)) {
      _favorites.remove(meal.idMeal);
    } else {
      _favorites[meal.idMeal] = meal;
    }

    print("FAVORITES COUNT: ${_favorites.length}");
    print("FAVS: $_favorites");

    notifyListeners();
  }
}
