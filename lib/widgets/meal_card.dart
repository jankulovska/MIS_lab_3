import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/meal.dart';


class MealCard extends StatelessWidget {
  final MealSummary meal;
  MealCard({required this.meal});


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: meal.strMealThumb,
              fit: BoxFit.cover,
              placeholder: (ctx, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (ctx, url, err) => Icon(Icons.image_not_supported),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(meal.strMeal, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}