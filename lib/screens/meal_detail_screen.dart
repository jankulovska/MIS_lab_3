import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    late MealDetail meal;
    if (arg is MealDetail) {
      meal = arg;
    } else {
      meal = arg as MealDetail;
    }
    return Scaffold(
      appBar: AppBar(title: Text(meal.strMeal)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(meal.strMealThumb, height: 220, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(meal.strMeal, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            if (meal.strCategory.isNotEmpty)
              Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text('Category: ${meal.strCategory}')),
            if (meal.strArea.isNotEmpty)
              Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text('Cuisine: ${meal.strArea}')),
            Divider(),
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text(meal.strInstructions)),
            Divider(),
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Ingridients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: meal.ingredients.entries.map((e) => Text('- ${e.key} : ${e.value}')).toList(),
              ),
            ),
            SizedBox(height: 12),
            if (meal.strYoutube != null && meal.strYoutube!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final url = Uri.parse(meal.strYoutube!);
                    if (await canLaunchUrl(url)) await launchUrl(url);
                  },
                  icon: Icon(Icons.play_circle_fill),
                  label: Text('Open YouTube'),
                ),
              ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}