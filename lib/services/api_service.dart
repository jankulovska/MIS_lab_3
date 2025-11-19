import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const _base = 'https://www.themealdb.com/api/json/v1/1';

  // Fetch all categories
  static Future<List<CategoryModel>> fetchCategories() async {
    final url = Uri.parse("$_base/categories.php"); // double quotes for interpolation
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final list = data['categories'] as List<dynamic>;
      return list.map((e) => CategoryModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load categories');
  }

  // Fetch meals by category
  static Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    final url = Uri.parse("$_base/filter.php?c=$category"); // double quotes
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final list = (data['meals'] ?? []) as List<dynamic>;
      return list.map((e) => MealSummary.fromJson(e)).toList();
    }
    throw Exception('Failed to load meals for category');
  }

  // Search meals
  static Future<List<MealSummary>> searchMeals(String query) async {
    final url = Uri.parse("$_base/search.php?s=$query");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final list = (data['meals'] ?? []) as List<dynamic>;
      return list.map((e) => MealSummary.fromJson(e)).toList();
    }
    throw Exception('Search failed');
  }

  // Lookup meal by ID
  static Future<MealDetail> lookupMeal(String id) async {
    final url = Uri.parse("$_base/lookup.php?i=$id");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final item = (data['meals'] as List<dynamic>).first;
      return MealDetail.fromJson(item);
    }
    throw Exception('Failed to load meal details');
  }

  // Fetch a random meal
  static Future<MealDetail> randomMeal() async {
    final url = Uri.parse("$_base/random.php");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final item = (data['meals'] as List<dynamic>).first;
      return MealDetail.fromJson(item);
    }
    throw Exception('Failed to load random meal');
  }
}
