import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favourites_service.dart';
import '../widgets/meal_card.dart';
import '../services/api_service.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = Provider.of<FavoriteService>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Favourite meals')),
      body: favs.isEmpty
          ? const Center(child: Text('You do not have favourite meals...'))
          : ListView.builder(
        itemCount: favs.length,
        itemBuilder: (ctx, i) {
          final meal = favs[i];
          return GestureDetector(
            onTap: () async {
              final detail = await ApiService.lookupMeal(meal.idMeal);
              Navigator.pushNamed(
                context,
                MealDetailScreen.routeName,
                arguments: detail,
              );
            },
            child: MealCard(meal: meal),
          );
        },
      ),
    );
  }
}
