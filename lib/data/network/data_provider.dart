import 'dart:convert';

import 'package:recipebook/model/drink_by_category_model.dart';
import 'package:recipebook/model/drink_categories_model.dart';
import 'package:recipebook/model/drink_ingredient_model.dart';
import 'package:recipebook/model/meal_by_category_model.dart';
import 'package:recipebook/model/meal_categories_model.dart';
import 'package:http/http.dart' as http;
import 'package:recipebook/model/meal_ingredient_model.dart';

class DataProvider {
  Future<CategoriesModel> getCategories() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return CategoriesModel.fromJson(parsed);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CategoriesDrinkModel> getDrinkCategories() async {
    final response = await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final data = CategoriesDrinkModel.fromJson(parsed);
      for (var item in data.drinks!) {
        await http
            .get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=${item.strCategory}'))
            .then((value) {
          final image = jsonDecode(value.body);
          final imageData = DrinkByCategories.fromJson(image);
          item.strThumb = imageData.drinks!.first.strDrinkThumb;
        });
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MealByCategoriesModel> getMealsByCategories(String categoryName) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return MealByCategoriesModel.fromJson(parsed);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DrinkByCategories> getDrinksByCategories(String categoryName) async {
    final response =
        await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=$categoryName'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return DrinkByCategories.fromJson(parsed);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DetailsMealIngredientModel> getMealsIngredient(String id) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return DetailsMealIngredientModel.fromJson(parsed);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DetailsDrinkIngredientModel> getDrinksIngredient(String id) async {
    final response = await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return DetailsDrinkIngredientModel.fromJson(parsed);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
