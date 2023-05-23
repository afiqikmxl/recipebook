// ignore_for_file: override_on_non_overriding_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipebook/bloc/details/details_event.dart';
import 'package:recipebook/bloc/details/details_state.dart';
import 'package:recipebook/data/repo/repo.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final Repository repository;

  DetailBloc(this.repository) : super(DetailInitialState()) {
    on<GetMealsIngredientEvent>((event, emit) async {
      try {
        final ingredient = await repository.getMealsIngredient(event.id);

        emit(DetailGetMealsIngredientUpdate(ingredient));
      } catch (e) {
        // emit(HomeCategoriesError(e));
      }
    });

    on<GetDrinksIngredientEvent>((event, emit) async {
      try {
        final ingredient = await repository.getDrinksIngredient(event.id);

        emit(DetailsGetDrinksIngredientUpdate(ingredient));
      } catch (e) {
        // emit(HomeCategoriesError(e));
      }
    });
  }
}
