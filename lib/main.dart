import 'package:flutter/material.dart';
import 'package:laboratory_exercise_2/screens/favourites_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/meals_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/favourites_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoriteService(),
      child: MealsApp(),
    ),
  );
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
        FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
      },
    );
  }
}