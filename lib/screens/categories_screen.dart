import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<CategoryModel>> _future;
  List<CategoryModel> _all = [];
  List<CategoryModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchCategories();
    _future.then((value) {
      setState(() {
        _all = value;
        _filtered = value;
      });
    });
  }

  void _search(String q) {
    final ql = q.toLowerCase();
    setState(() {
      _filtered = _all.where((c) => c.strCategory.toLowerCase().contains(ql) || c.strCategoryDescription.toLowerCase().contains(ql)).toList();
    });
  }


  void _openRandom() async {
    final meal = await ApiService.randomMeal();
    Navigator.of(context).pushNamed('/meal-detail', arguments: meal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meal categories'),
          actions: [
            IconButton(
              icon: Icon(Icons.shuffle),
              tooltip: 'Random recipe',
              onPressed: _openRandom,
            )
          ],
        ),
        body: FutureBuilder<List<CategoryModel>>(
            future: _future,
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
              if (snap.hasError) return Center(child: Text('Error: \${snap.error}'));

              return Column(
                  children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
              decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search a category', border: OutlineInputBorder()),
              onChanged: _search,
              ),
              ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filtered.length,
                        itemBuilder: (ctx, i) {
                          final cat = _filtered[i];
                          return GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(MealsScreen.routeName, arguments: cat.strCategory),
                            child: CategoryCard(category: cat),
                          );
                        },
                      ),
                    ),
                  ],
              );
            },
        ),
    );
  }
}