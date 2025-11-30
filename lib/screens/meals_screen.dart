import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late String category;
  late Future<List<MealSummary>> _future;
  List<MealSummary> _all = [];
  List<MealSummary> _filtered = [];
  final _searchCtrl = TextEditingController();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    category = ModalRoute.of(context)!.settings.arguments as String;
    _future = ApiService.fetchMealsByCategory(category);
    _future.then((list) {
      setState(() {
        _all = list;
        _filtered = list;
      });
    });
  }

  void _search(String q) async {
    if (q.trim().isEmpty) {
      setState(() => _filtered = _all);
      return;
    }
    final results = await ApiService.searchMeals(q);
    final byCat = results.where((m) => m.strMeal.isNotEmpty).toList();
    final idsInCategory = _all.map((e) => e.idMeal).toSet();
    final intersection = byCat.where((m) => idsInCategory.contains(m.idMeal)).toList();
    setState(() {
      _filtered = intersection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meals: $category')),
      body: FutureBuilder<List<MealSummary>>(
        future: _future,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Error: \${snap.error}'));


          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search for meals in the category', border: OutlineInputBorder()),
                  onSubmitted: _search,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.62,
                  ),
                  itemCount: _filtered.length,
                  itemBuilder: (ctx, i) {
                    final meal = _filtered[i];
                    return GestureDetector(
                      onTap: () async {
                        final detail = await ApiService.lookupMeal(meal.idMeal);
                        Navigator.of(context).pushNamed(
                          MealDetailScreen.routeName,
                          arguments: detail,
                        );
                      },
                      child: MealCard(meal: meal),
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