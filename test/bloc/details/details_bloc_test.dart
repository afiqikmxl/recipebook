// ignore_for_file: depend_on_referenced_packages, override_on_non_overriding_member

import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:recipebook/bloc/details/details_bloc.dart';
import 'package:recipebook/bloc/details/details_event.dart';
import 'package:recipebook/bloc/details/details_state.dart';
import 'package:recipebook/data/repo/repo.dart';
import 'package:recipebook/model/drink_ingredient_model.dart';
import 'package:recipebook/model/meal_ingredient_model.dart';
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
  final bloc = DetailBloc(repository);

  late MockHttpClient mockHttpClient;

  setUp(() {
    registerFallbackValue(Uri());
    mockHttpClient = MockHttpClient();
    when(() => mockHttpClient.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=52874')))
        .thenAnswer((_) async => http.Response('''
{"meals":[{"idMeal":"52874","strMeal":"Beef and Mustard Pie","strDrinkAlternate":null,"strCategory":"Beef","strArea":"British","strInstructions":"Preheat the oven to 150C/300F/Gas 2.rnToss the beef and flour together in a bowl with some salt and black pepper.rnHeat a large casserole until hot, add half of the rapeseed oil and enough of the beef to just cover the bottom of the casserole.rnFry until browned on each side, then remove and set aside. Repeat with the remaining oil and beef.rnReturn the beef to the pan, add the wine and cook until the volume of liquid has reduced by half, then add the stock, onion, carrots, thyme and mustard, and season well with salt and pepper.rnCover with a lid and place in the oven for two hours.rnRemove from the oven, check the seasoning and set aside to cool. Remove the thyme.rnWhen the beef is cool and you're ready to assemble the pie, preheat the oven to 200C/400F/Gas 6.rnTransfer the beef to a pie dish, brush the rim with the beaten egg yolks and lay the pastry over the top. Brush the top of the pastry with more beaten egg.rnTrim the pastry so there is just enough excess to crimp the edges, then place in the oven and bake for 30 minutes, or until the pastry is golden-brown and cooked through.rnFor the green beans, bring a saucepan of salted water to the boil, add the beans and cook for 4-5 minutes, or until just tender.rnDrain and toss with the butter, then season with black pepper.rnTo serve, place a large spoonful of pie onto each plate with some green beans alongside.","strMealThumb":"https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg","strTags":"Meat,Pie","strYoutube":"https://www.youtube.com/watch?v=nMyBC9staMU","strIngredient1":"Beef","strIngredient2":"Plain Flour","strIngredient3":"Rapeseed Oil","strIngredient4":"Red Wine","strIngredient5":"Beef Stock","strIngredient6":"Onion","strIngredient7":"Carrots","strIngredient8":"Thyme","strIngredient9":"Mustard","strIngredient10":"Egg Yolks","strIngredient11":"Puff Pastry","strIngredient12":"Green Beans","strIngredient13":"Butter","strIngredient14":"Salt","strIngredient15":"Pepper","strIngredient16":"","strIngredient17":"","strIngredient18":"","strIngredient19":"","strIngredient20":"","strMeasure1":"1kg","strMeasure2":"2 tbs","strMeasure3":"2 tbs","strMeasure4":"200ml","strMeasure5":"400ml","strMeasure6":"1 finely sliced","strMeasure7":"2 chopped","strMeasure8":"3 sprigs","strMeasure9":"2 tbs","strMeasure10":"2 free-range","strMeasure11":"400g","strMeasure12":"300g","strMeasure13":"25g","strMeasure14":"pinch","strMeasure15":"pinch","strMeasure16":"","strMeasure17":"","strMeasure18":"","strMeasure19":"","strMeasure20":"","strSource":"https://www.bbc.co.uk/food/recipes/beef_and_mustard_pie_58002","strImageSource":null,"strCreativeCommonsConfirmed":null,"dateModified":null}]}
''', 200));
    when(() => mockHttpClient.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=15300')))
        .thenAnswer((_) async => http.Response('''
{"drinks":[{"idDrink":"15300","strDrink":"3-Mile Long Island Iced Tea","strDrinkAlternate":null,"strTags":null,"strVideo":null,"strCategory":"Ordinary Drink","strIBA":null,"strAlcoholic":"Alcoholic","strGlass":"Collins Glass","strInstructions":"Fill 14oz glass with ice and alcohol. Fill 2/3 glass with cola and remainder with sweet & sour. Top with dash of bitters and lemon wedge.","strInstructionsES":null,"strInstructionsDE":"Fu00fcllen Sie ein 12 cl. Glas mit Eis und Alkohol. Fu00fcllen Sie 2/3 des Glases mit Cola und den Rest mit Su00fcu00df-Sauer. Mit einem Schuss Bitter und Zitronenkeil garnieren.","strInstructionsFR":null,"strInstructionsIT":"Riempi un bicchiere da almeno 400ml con ghiaccio e alcol. Riempire i restanti 2/3 di bicchiere di cola e il resto di bevanda sweet & sour. Completare con un pizzico di bitter e uno spicchio di limone.","strInstructionsZH-HANS":null,"strInstructionsZH-HANT":null,"strDrinkThumb":"https://www.thecocktaildb.com/images/media/drink/rrtssw1472668972.jpg","strIngredient1":"Gin","strIngredient2":"Light rum","strIngredient3":"Tequila","strIngredient4":"Triple sec","strIngredient5":"Vodka","strIngredient6":"Coca-Cola","strIngredient7":"Sweet and sour","strIngredient8":"Bitters","strIngredient9":"Lemon","strIngredient10":null,"strIngredient11":null,"strIngredient12":null,"strIngredient13":null,"strIngredient14":null,"strIngredient15":null,"strMeasure1":"1/2 oz","strMeasure2":"1/2 oz","strMeasure3":"1/2 oz","strMeasure4":"1/2 oz","strMeasure5":"1/2 oz","strMeasure6":"1/2 oz","strMeasure7":"1-2 dash ","strMeasure8":"1 wedge ","strMeasure9":"Garnish with","strMeasure10":null,"strMeasure11":null,"strMeasure12":null,"strMeasure13":null,"strMeasure14":null,"strMeasure15":null,"strImageSource":null,"strImageAttribution":null,"strCreativeCommonsConfirmed":"No","dateModified":"2016-08-31 19:42:52"}]}
''', 200));

    repository.client = mockHttpClient;
  });

//for meals ingredient details
  test('should emit DetailGetMealsIngredientUpdate when GetMealsIngredientEvent is added', () async {
    Meals mealsExpected = Meals.fromJson(jsonDecode('''
{"idMeal":"52874","strMeal":"Beef and Mustard Pie","strDrinkAlternate":null,"strCategory":"Beef","strArea":"British","strInstructions":"Preheat the oven to 150C/300F/Gas 2.rnToss the beef and flour together in a bowl with some salt and black pepper.rnHeat a large casserole until hot, add half of the rapeseed oil and enough of the beef to just cover the bottom of the casserole.rnFry until browned on each side, then remove and set aside. Repeat with the remaining oil and beef.rnReturn the beef to the pan, add the wine and cook until the volume of liquid has reduced by half, then add the stock, onion, carrots, thyme and mustard, and season well with salt and pepper.rnCover with a lid and place in the oven for two hours.rnRemove from the oven, check the seasoning and set aside to cool. Remove the thyme.rnWhen the beef is cool and you're ready to assemble the pie, preheat the oven to 200C/400F/Gas 6.rnTransfer the beef to a pie dish, brush the rim with the beaten egg yolks and lay the pastry over the top. Brush the top of the pastry with more beaten egg.rnTrim the pastry so there is just enough excess to crimp the edges, then place in the oven and bake for 30 minutes, or until the pastry is golden-brown and cooked through.rnFor the green beans, bring a saucepan of salted water to the boil, add the beans and cook for 4-5 minutes, or until just tender.rnDrain and toss with the butter, then season with black pepper.rnTo serve, place a large spoonful of pie onto each plate with some green beans alongside.","strMealThumb":"https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg","strTags":"Meat,Pie","strYoutube":"https://www.youtube.com/watch?v=nMyBC9staMU","strIngredient1":"Beef","strIngredient2":"Plain Flour","strIngredient3":"Rapeseed Oil","strIngredient4":"Red Wine","strIngredient5":"Beef Stock","strIngredient6":"Onion","strIngredient7":"Carrots","strIngredient8":"Thyme","strIngredient9":"Mustard","strIngredient10":"Egg Yolks","strIngredient11":"Puff Pastry","strIngredient12":"Green Beans","strIngredient13":"Butter","strIngredient14":"Salt","strIngredient15":"Pepper","strIngredient16":"","strIngredient17":"","strIngredient18":"","strIngredient19":"","strIngredient20":"","strMeasure1":"1kg","strMeasure2":"2 tbs","strMeasure3":"2 tbs","strMeasure4":"200ml","strMeasure5":"400ml","strMeasure6":"1 finely sliced","strMeasure7":"2 chopped","strMeasure8":"3 sprigs","strMeasure9":"2 tbs","strMeasure10":"2 free-range","strMeasure11":"400g","strMeasure12":"300g","strMeasure13":"25g","strMeasure14":"pinch","strMeasure15":"pinch","strMeasure16":"","strMeasure17":"","strMeasure18":"","strMeasure19":"","strMeasure20":"","strSource":"https://www.bbc.co.uk/food/recipes/beef_and_mustard_pie_58002","strImageSource":null,"strCreativeCommonsConfirmed":null,"dateModified":null}
'''));
    final categories = DetailsMealIngredientModel(meals: [mealsExpected]);

    when(() => repository.getMealsIngredient('52874')).thenAnswer((_) async => categories);
    bloc.add(const GetMealsIngredientEvent('52874'));

    await expectLater(
      bloc.stream,
      emits(isA<DetailGetMealsIngredientUpdate>().having(
        (state) => state.apiResponse.meals,
        'detail ingredient',
        categories.meals,
      )),
    );
  });

//for drinks ingredient details
  test('should emit DetailsGetDrinksIngredientUpdate when GetDrinksIngredientEvent is added', () async {
    Drinks drinkExpected = Drinks.fromJson(jsonDecode('''
{"drinks":[{"idDrink":"15300","strDrink":"3-Mile Long Island Iced Tea","strDrinkAlternate":null,"strTags":null,"strVideo":null,"strCategory":"Ordinary Drink","strIBA":null,"strAlcoholic":"Alcoholic","strGlass":"Collins Glass","strInstructions":"Fill 14oz glass with ice and alcohol. Fill 2/3 glass with cola and remainder with sweet & sour. Top with dash of bitters and lemon wedge.","strInstructionsES":null,"strInstructionsDE":"Fu00fcllen Sie ein 12 cl. Glas mit Eis und Alkohol. Fu00fcllen Sie 2/3 des Glases mit Cola und den Rest mit Su00fcu00df-Sauer. Mit einem Schuss Bitter und Zitronenkeil garnieren.","strInstructionsFR":null,"strInstructionsIT":"Riempi un bicchiere da almeno 400ml con ghiaccio e alcol. Riempire i restanti 2/3 di bicchiere di cola e il resto di bevanda sweet & sour. Completare con un pizzico di bitter e uno spicchio di limone.","strInstructionsZH-HANS":null,"strInstructionsZH-HANT":null,"strDrinkThumb":"https://www.thecocktaildb.com/images/media/drink/rrtssw1472668972.jpg","strIngredient1":"Gin","strIngredient2":"Light rum","strIngredient3":"Tequila","strIngredient4":"Triple sec","strIngredient5":"Vodka","strIngredient6":"Coca-Cola","strIngredient7":"Sweet and sour","strIngredient8":"Bitters","strIngredient9":"Lemon","strIngredient10":null,"strIngredient11":null,"strIngredient12":null,"strIngredient13":null,"strIngredient14":null,"strIngredient15":null,"strMeasure1":"1/2 oz","strMeasure2":"1/2 oz","strMeasure3":"1/2 oz","strMeasure4":"1/2 oz","strMeasure5":"1/2 oz","strMeasure6":"1/2 oz","strMeasure7":"1-2 dash ","strMeasure8":"1 wedge ","strMeasure9":"Garnish with","strMeasure10":null,"strMeasure11":null,"strMeasure12":null,"strMeasure13":null,"strMeasure14":null,"strMeasure15":null,"strImageSource":null,"strImageAttribution":null,"strCreativeCommonsConfirmed":"No","dateModified":"2016-08-31 19:42:52"}]}
'''));
    final categories = DetailsDrinkIngredientModel(drinks: [drinkExpected]);

    when(() => repository.getDrinksIngredient('15300')).thenAnswer((_) async => categories);

    bloc.add(const GetDrinksIngredientEvent('15300'));

    await expectLater(
      bloc.stream,
      emits(isA<DetailsGetDrinksIngredientUpdate>().having(
        (state) => state.apiResponse.drinks,
        'detail ingredient',
        categories.drinks,
      )),
    );
  });
}
