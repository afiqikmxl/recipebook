import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetCategoriesEvent extends HomeEvent {
  const GetCategoriesEvent();
  @override
  List<Object?> get props => [];
}

class GetDrinkCategoriesEvent extends HomeEvent {
  const GetDrinkCategoriesEvent();
  @override
  List<Object?> get props => [];
}

class GetMealsByCategoryEvent extends HomeEvent {
  final String categoryName;
  const GetMealsByCategoryEvent(this.categoryName);
  @override
  List<Object?> get props => [categoryName];
}

class GetDrinksByCategoryEvent extends HomeEvent {
  final String categoryName;
  const GetDrinksByCategoryEvent(this.categoryName);
  @override
  List<Object?> get props => [categoryName];
}
