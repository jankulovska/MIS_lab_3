import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/meals_screen.dart';
import 'services/api_service.dart';


void main() {
  runApp(MealsApp());
}


class MealsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals Explorer',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.deepOrange),
      initialRoute: '/',
      routes: {
        '/': (ctx) => CategoriesScreen(),
        MealsScreen.routeName: (ctx) => MealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
    );
  }
}