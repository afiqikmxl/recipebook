import 'package:recipebook/data/network/data_provider.dart';
import 'package:recipebook/data/repo/repo_impl.dart';
import 'package:recipebook/model/drink_by_category_model.dart';
import 'package:recipebook/model/drink_categories_model.dart';
import 'package:recipebook/model/drink_ingredient_model.dart';
import 'package:recipebook/model/meal_by_category_model.dart';
import 'package:recipebook/model/meal_categories_model.dart';
import 'package:recipebook/model/meal_ingredient_model.dart';

class Repo {
  static Repository getInstance() {
    return RepoImpl(
      dataProvider: DataProvider(),
    );
  }
}

abstract class Repository {
  Future<CategoriesModel> getCategories();
  Future<CategoriesDrinkModel> getDrinkCategories();
  Future<MealByCategoriesModel> getMealsByCategories(String categoryName);
  Future<DrinkByCategories> getDrinksByCategories(String categoryName);
  Future<DetailsMealIngredientModel> getMealsIngredient(String id);
  Future<DetailsDrinkIngredientModel> getDrinksIngredient(String id);
}
