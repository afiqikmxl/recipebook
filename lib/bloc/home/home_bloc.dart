// ignore_for_file: override_on_non_overriding_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipebook/bloc/home/home_event.dart';
import 'package:recipebook/bloc/home/home_state.dart';
import 'package:recipebook/data/repo/repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository repository;

  HomeBloc(this.repository) : super(HomeInitialState()) {
    on<GetCategoriesEvent>((event, emit) async {
      try {
        final categories = await repository.getCategories();

        emit(HomeGetCategoriesUpdate(categories));
      } catch (e) {
        // emit(HomeCategoriesError(e));
      }
    });
    on<GetDrinkCategoriesEvent>((event, emit) async {
      try {
        final categories = await repository.getDrinkCategories();

        emit(HomeGetDrinkCategoriesUpdate(categories));
      } catch (e) {
        // emit(HomeCategoriesError(e));
      }
    });
    on<GetMealsByCategoryEvent>((event, emit) async {
      try {
        final meals = await repository.getMealsByCategories(event.categoryName);

        emit(HomeGetMealsByCategoryUpdate(meals));
      } catch (e) {
        // emit(HomeCategoriesError(e));
      }
    });
    on<GetDrinksByCategoryEvent>((event, emit) async {
      try {
        final meals = await repository.getDrinksByCategories(event.categoryName);

        emit(HomeGetDrinksByCategoryUpdate(meals));
      } catch (e) {
        // emit(HomeCategoriesError(e));
      }
    });
  }
}
