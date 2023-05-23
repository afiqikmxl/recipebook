// ignore_for_file: depend_on_referenced_packages, override_on_non_overriding_member

import 'package:mocktail/mocktail.dart';
import 'package:recipebook/bloc/home/home_bloc.dart';
import 'package:recipebook/bloc/home/home_event.dart';
import 'package:recipebook/bloc/home/home_state.dart';
import 'package:recipebook/data/repo/repo.dart';
import 'package:recipebook/model/drink_by_category_model.dart' as drinks;
import 'package:recipebook/model/drink_categories_model.dart';
import 'package:recipebook/model/meal_by_category_model.dart';
import 'package:recipebook/model/meal_categories_model.dart';
import 'package:test/test.dart';

import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class MockRepository extends Mock implements Repository {
  http.Client? client;

  @override
  http.Client get httpClient => client ??= MockHttpClient();
}

void main() {
  final repository = MockRepository();
  final bloc = HomeBloc(repository);

  late MockHttpClient mockHttpClient;

  setUp(() {
    registerFallbackValue(Uri());
    mockHttpClient = MockHttpClient();
    when(() =>
        mockHttpClient.get(
            Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'))).thenAnswer((_) async => http.Response(
        '{"categories": [{"idCategory":"1","strCategory":"Beef","strCategoryThumb":"https://www.themealdb.com/images/category/beef.png","strCategoryDescription":"Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]"},{"idCategory":"2","strCategory":"Chicken","strCategoryThumb":"https://www.themealdb.com/images/category/chicken.png","strCategoryDescription":"Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets."},]}',
        200));
    when(() => mockHttpClient.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'))).thenAnswer(
        (_) async => http.Response('{"drinks":[{"strCategory":"Ordinary Drink"},{"strCategory":"Cocktail"}}', 200));
    when(() => mockHttpClient.get(
        Uri.parse(
            'https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef'))).thenAnswer((_) async => http.Response(
        '{"meals":[{"strMeal":"Beef and Mustard Pie","strMealThumb":"https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg","idMeal":"52874"},{"strMeal":"Beef and Oyster pie","strMealThumb":"https://www.themealdb.com/images/media/meals/wrssvt1511556563.jpg","idMeal":"52878"},]}',
        200));
    when(() =>
            mockHttpClient.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary%20Drink')))
        .thenAnswer((_) async => http.Response(
            '{"drinks":[{"strDrink":"3-Mile Long Island Iced Tea","strDrinkThumb":"https://www.thecocktaildb.com/images/media/drink/rrtssw1472668972.jpg","idDrink":"15300"},{"strDrink":"410 Gone","strDrinkThumb":"https://www.thecocktaildb.com/images/media/drink/xtuyqv1472669026.jpg","idDrink":"13581"},]}',
            200));
    repository.client = mockHttpClient;
  });

//for meals category
  test('should emit HomeGetCategoriesUpdate when GetCategoriesEvent is added', () async {
    final categories = CategoriesModel(categories: [
      Categories(
          idCategory: "1",
          strCategory: "Beef",
          strCategoryThumb: "https://www.themealdb.com/images/category/beef.png",
          strCategoryDescription:
              "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]"),
      Categories(
          idCategory: "2",
          strCategory: "Chicken",
          strCategoryThumb: "https://www.themealdb.com/images/category/chicken.png",
          strCategoryDescription:
              "Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.")
    ]);

    when(repository.getCategories).thenAnswer((_) async => categories);

    bloc.add(const GetCategoriesEvent());

    await expectLater(
      bloc.stream,
      emits(isA<HomeGetCategoriesUpdate>().having(
        (state) => state.apiResponse.categories,
        'categories',
        categories.categories,
      )),
    );
  });

//for drinks category
  test('should emit HomeGetDrinkCategoriesUpdate when GetDrinkCategoriesEvent is added', () async {
    final categories = CategoriesDrinkModel(drinks: [
      Drinks(
        strCategory: "Ordinary Drink",
        strThumb: "https://www.thecocktaildb.com/images/media/drink/rrtssw1472668972.jpg",
      ),
      Drinks(
        strCategory: "Cocktail",
        strThumb: "https://www.thecocktaildb.com/images/media/drink/yqvvqs1475667388.jpg",
      ),
    ]);

    when(repository.getDrinkCategories).thenAnswer((_) async => categories);

    bloc.add(const GetDrinkCategoriesEvent());

    await expectLater(
      bloc.stream,
      emits(isA<HomeGetDrinkCategoriesUpdate>().having(
        (state) => state.apiResponse.drinks,
        'categories',
        categories.drinks,
      )),
    );
  });

//for get meals by category
  test('should emit HomeGetMealsByCategoryUpdate when GetMealsByCategoryEvent is added', () async {
    final categories = MealByCategoriesModel(meals: [
      Meals(
          strMeal: "Beef and Mustard Pie",
          strMealThumb: "https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg",
          idMeal: "52874"),
      Meals(
          strMeal: "Beef and Oyster pie",
          strMealThumb: "https://www.themealdb.com/images/media/meals/wrssvt1511556563.jpg",
          idMeal: "52878")
    ]);

    when(() => repository.getMealsByCategories('Beef')).thenAnswer((_) async => categories);

    bloc.add(const GetMealsByCategoryEvent('Beef'));

    await expectLater(
      bloc.stream,
      emits(isA<HomeGetMealsByCategoryUpdate>().having(
        (state) => state.apiResponse.meals,
        'meals',
        categories.meals,
      )),
    );
  });

//for get drinks by category
  test('should emit HomeGetDrinksByCategoryUpdate when GetDrinksByCategoryEvent is added', () async {
    final categories = drinks.DrinkByCategories(drinks: [
      drinks.Drinks(
        strDrink: "3-Mile Long Island Iced Tea",
        strDrinkThumb: "https://www.thecocktaildb.com/images/media/drink/rrtssw1472668972.jpg",
        idDrink: "15300",
      ),
      drinks.Drinks(
          strDrink: "410 Gone",
          strDrinkThumb: "https://www.thecocktaildb.com/images/media/drink/xtuyqv1472669026.jpg",
          idDrink: "13581")
    ]);

    when(() => repository.getDrinksByCategories('Ordinary Drink')).thenAnswer((_) async => categories);

    bloc.add(const GetDrinksByCategoryEvent('Ordinary Drink'));

    await expectLater(
      bloc.stream,
      emits(isA<HomeGetDrinksByCategoryUpdate>().having(
        (state) => state.apiResponse.drinks,
        'drinks',
        categories.drinks,
      )),
    );
  });
}
