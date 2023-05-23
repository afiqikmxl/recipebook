import 'package:recipebook/data/network/data_provider.dart';
import 'package:recipebook/data/repo/repo.dart';
import 'package:recipebook/model/drink_by_category_model.dart';
import 'package:recipebook/model/drink_categories_model.dart';
import 'package:recipebook/model/drink_ingredient_model.dart';
import 'package:recipebook/model/meal_by_category_model.dart';
import 'package:recipebook/model/meal_categories_model.dart';
import 'package:recipebook/model/meal_ingredient_model.dart';

class RepoImpl extends Repository {
  RepoImpl({required DataProvider dataProvider}) : _dataProvider = dataProvider;

  final DataProvider _dataProvider;

  @override
  Future<CategoriesModel> getCategories() {
    return _dataProvider.getCategories();
  }

  @override
  Future<CategoriesDrinkModel> getDrinkCategories() {
    return _dataProvider.getDrinkCategories();
  }

  @override
  Future<MealByCategoriesModel> getMealsByCategories(String categoryName) {
    return _dataProvider.getMealsByCategories(categoryName);
  }

  @override
  Future<DrinkByCategories> getDrinksByCategories(String categoryName) {
    return _dataProvider.getDrinksByCategories(categoryName);
  }

   @override
  Future<DetailsMealIngredientModel> getMealsIngredient(String id) {
    return _dataProvider.getMealsIngredient(id);
  }

  @override
  Future<DetailsDrinkIngredientModel> getDrinksIngredient(String id) {
    return _dataProvider.getDrinksIngredient(id);
  }
}
