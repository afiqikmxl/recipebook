import 'package:equatable/equatable.dart';
import 'package:recipebook/model/drink_by_category_model.dart';
import 'package:recipebook/model/drink_categories_model.dart';
import 'package:recipebook/model/meal_by_category_model.dart';
import 'package:recipebook/model/meal_categories_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeGetCategoriesUpdate extends HomeState {
  final CategoriesModel apiResponse;

  const HomeGetCategoriesUpdate(this.apiResponse);
  @override
  List<Object?> get props => [apiResponse];
}

class HomeGetDrinkCategoriesUpdate extends HomeState {
  final CategoriesDrinkModel apiResponse;

  const HomeGetDrinkCategoriesUpdate(this.apiResponse);
  @override
  List<Object?> get props => [apiResponse];
}

class HomeGetMealsByCategoryUpdate extends HomeState {
  final MealByCategoriesModel apiResponse;

  const HomeGetMealsByCategoryUpdate(this.apiResponse);
  @override
  List<Object?> get props => [apiResponse];
}

class HomeGetDrinksByCategoryUpdate extends HomeState {
  final DrinkByCategories apiResponse;

  const HomeGetDrinksByCategoryUpdate(this.apiResponse);
  @override
  List<Object?> get props => [apiResponse];
}

class LoadingState extends HomeState {
  final bool? loading;
  const LoadingState(this.loading);
  @override
  List<Object?> get props => [loading];
}
