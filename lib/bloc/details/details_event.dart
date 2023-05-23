import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class GetMealsIngredientEvent extends DetailEvent {
  final String id;
  const GetMealsIngredientEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class GetDrinksIngredientEvent extends DetailEvent {
  final String id;
  const GetDrinksIngredientEvent(this.id);
  @override
  List<Object?> get props => [id];
}
