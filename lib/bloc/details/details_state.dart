import 'package:equatable/equatable.dart';
import 'package:recipebook/model/drink_ingredient_model.dart';
import 'package:recipebook/model/meal_ingredient_model.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailInitialState extends DetailState {
  @override
  List<Object?> get props => [];
}

class DetailGetMealsIngredientUpdate extends DetailState {
  final DetailsMealIngredientModel apiResponse;

  const DetailGetMealsIngredientUpdate(this.apiResponse);
  @override
  List<Object?> get props => [apiResponse];
}

class DetailsGetDrinksIngredientUpdate extends DetailState {
  final DetailsDrinkIngredientModel apiResponse;

  const DetailsGetDrinksIngredientUpdate(this.apiResponse);
  @override
  List<Object?> get props => [apiResponse];
}

class LoadingState extends DetailState {
  final bool? loading;
  const LoadingState(this.loading);
  @override
  List<Object?> get props => [loading];
}
