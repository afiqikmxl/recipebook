import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipebook/bloc/details/details_bloc.dart';
import 'package:recipebook/bloc/details/details_event.dart';
import 'package:recipebook/bloc/details/details_state.dart';
import 'package:recipebook/confiig/loading.dart';
import 'package:recipebook/confiig/size.dart';
import 'package:recipebook/data/repo/repo.dart';
import 'package:recipebook/model/drink_ingredient_model.dart';
import 'package:recipebook/model/meal_ingredient_model.dart';
import 'package:recipebook/widget/shimmer.dart';
import 'package:recipebook/widget/tab_bar.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatefulWidget {
  final String? image;
  final String? id;
  final String? type;
  const DetailsPage({super.key, required this.image, required this.id, required this.type});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Color color = const Color.fromRGBO(201, 83, 83, 1);
  int selectedIndex = 1;
  int servingCount = 1;
  final DetailBloc bloc = DetailBloc(Repo.getInstance());
  DetailsMealIngredientModel? mealData;
  DetailsDrinkIngredientModel? drinksData;
  List<String>? ingredientDisplay;
  List<String>? measureDisplay;
  List<String> digitOnly = [];
  List<String> unitMeasurement = [];
  int? iLength;
  int? mLength;

  List<Icon> icon = [
    Icon(
      Icons.star_border_rounded,
      size: 5.h,
    ),
    Icon(
      Icons.bookmark_border_outlined,
      size: 5.h,
    ),
    Icon(
      Icons.share_outlined,
      size: 5.h,
    )
  ];

  @override
  void initState() {
    super.initState();
    print("THE ID");
    print(widget.id!);
    bloc.add(widget.type == 'food' ? GetMealsIngredientEvent(widget.id!) : GetDrinksIngredientEvent(widget.id!));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<DetailBloc, DetailState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is DetailGetMealsIngredientUpdate) {
            hideLoading();
            if (state.apiResponse.meals!.isNotEmpty) {
              mealData = state.apiResponse;
              setMealIngredient(data: mealData);
              setMealMeasure(data: mealData);
            } else {}
          }
          if (state is DetailsGetDrinksIngredientUpdate) {
            hideLoading();
            if (state.apiResponse.drinks!.isNotEmpty) {
              drinksData = state.apiResponse;
              setMealIngredient(drinkData: drinksData);
              setMealMeasure(drinkData: drinksData);
            } else {}
          } else if (state is LoadingState) {
            if (state.loading == true) {
              showLoading();
            } else {
              hideLoading();
            }
          }

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const BackButton(color: Colors.black),
            ),
            body: SizedBox(
              width: width,
              height: height,
              child: Stack(
                children: widget.type == 'food'
                    ? [
                        mealData != null
                            ? imageWidget(true, data: mealData)
                            : const ShimmerContainer(
                                enableShimmer: true,
                              ),
                        mealData != null
                            ? detailsWidget(true, data: mealData)
                            : const ShimmerContainer(
                                enableShimmer: true,
                              ),
                      ]
                    : [
                        drinksData != null
                            ? imageWidget(false, drinkData: drinksData)
                            : const ShimmerContainer(
                                enableShimmer: true,
                              ),
                        drinksData != null
                            ? detailsWidget(false, drinkData: drinksData)
                            : const ShimmerContainer(
                                enableShimmer: true,
                              ),
                      ],
              ),
            ),
          );
        });
  }

  imageWidget(bool isFood, {DetailsMealIngredientModel? data, DetailsDrinkIngredientModel? drinkData}) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height * 0.45,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(isFood ? data!.meals!.first.strMealThumb! : drinkData!.drinks!.first.strDrinkThumb!),
            fit: BoxFit.cover),
      ),
      child: Stack(children: [
        Positioned(
          top: kIsWeb ? 7.h : 17.h,
          left: 2.h,
          child: SizedBox(
            child: Row(
              children: [
                Icon(
                  Icons.star_rate_rounded,
                  size: 4.h,
                ),
                Text(
                  (Random().nextDouble() * 5).toStringAsFixed(1),
                  style: GoogleFonts.quicksand(
                    fontSize: kIsWeb ? 5.sp : 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const AppPadding(denominator: 2).horizontal(),
                Text(
                  (Random().nextDouble() * 30).toStringAsFixed(2),
                  style: GoogleFonts.quicksand(
                    fontSize: kIsWeb ? 5.sp : 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 14.h,
          left: 2.h,
          child: Container(
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 10.h,
              )),
        )
      ]),
    );
  }

  detailsWidget(bool isFood, {DetailsMealIngredientModel? data, DetailsDrinkIngredientModel? drinkData}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffF3F6FB),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(30),
          ),
        ),
        width: double.infinity,
        height: height * 0.60,
        padding: EdgeInsets.symmetric(vertical: screenPadding / 2, horizontal: screenPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 5.h,
                      ),
                      const AppPadding(denominator: 2).horizontal(),
                      Text(
                        Random().nextInt(100).toString(),
                        style: GoogleFonts.quicksand(
                          fontSize: kIsWeb ? 10.sp : 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      for (var item in icon) ...[
                        item,
                        const AppPadding(denominator: 2).horizontal(),
                      ]
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.blueGrey.shade100,
              ),
              const AppPadding(denominator: 2).vertical(),
              widget.type == 'food'
                  ? ingredientsDetails(true, data: data)
                  : ingredientsDetails(false, drinkData: drinkData),
            ],
          ),
        ),
      ),
    );
  }

  ingredientsDetails(bool isFood, {DetailsMealIngredientModel? data, DetailsDrinkIngredientModel? drinkData}) {
    List<TabBarAttribute> data = [
      TabBarAttribute(
          isSelected: selectedIndex == 1 ? true : false,
          label: 'Ingredients',
          ontap: () {
            setState(() {
              selectedIndex = 1;
            });
          }),
      TabBarAttribute(
          isSelected: selectedIndex == 2 ? true : false,
          label: 'Steps',
          ontap: () {
            setState(() {
              selectedIndex = 2;
            });
          }),
      TabBarAttribute(
          isSelected: selectedIndex == 3 ? true : false,
          label: 'Nutrition',
          ontap: () {
            setState(() {
              selectedIndex = 3;
            });
          }),
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05 / 2),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var item in data) ...[TabBarWidget(field: item)]
              ],
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        listData(selectedIndex)
      ],
    );
  }

  listData(int selected) {
    switch (selected) {
      case 1:
        return SizedBox(
          width: double.infinity,
          child: ingredientPerServing(),
        );
      case 2:
        return Container(
          width: double.infinity,
          height: 50.h,
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.type == 'food'
                      ? mealData!.meals!.first.strInstructions!
                      : drinksData!.drinks!.first.strInstructions!,
                  style: GoogleFonts.quicksand(
                    fontSize: kIsWeb ? 10.sp : 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        );
      case 3:
        return Container(
          width: double.infinity,
          height: 50.h,
          color: Colors.transparent,
          child: Center(
            child: Text(
              "NOTHING HERE :)",
              style: GoogleFonts.quicksand(
                fontSize: kIsWeb ? 10.sp : 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    }
  }

  ingredientPerServing() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingredients For",
                  style: GoogleFonts.quicksand(
                    fontSize: kIsWeb ? 10.sp : 24.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$servingCount servings',
                  style: GoogleFonts.quicksand(
                    fontSize: kIsWeb ? 10.sp : 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      servingCount += 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.add,
                      size: 3.h,
                      color: Colors.white,
                    ),
                  ),
                ),
                const AppPadding(denominator: 1).horizontal(),
                Text(
                  servingCount.toString(),
                  style: GoogleFonts.quicksand(
                    fontSize: kIsWeb ? 10.sp : 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const AppPadding(denominator: 1).horizontal(),
                GestureDetector(
                  onTap: servingCount == 1
                      ? () {}
                      : () {
                          setState(() {
                            servingCount -= 1;
                          });
                        },
                  child: Container(
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(8),
                      child: FaIcon(
                        FontAwesomeIcons.minus,
                        size: 3.h,
                        color: Colors.white,
                      )),
                )
              ],
            )
          ],
        ),
        for (int i = 0; i < iLength!; i++) ...[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 2.h,
            ),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.type == 'food'
                              ? 'https://www.themealdb.com/images/ingredients/${ingredientDisplay![i]}.png'
                              : 'https://www.thecocktaildb.com/images/ingredients/${ingredientDisplay![i]}-Small.png'))),
                ),
                const AppPadding(denominator: 1).horizontal(),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    ingredientDisplay![i],
                    style: GoogleFonts.quicksand(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    '${changeData(measureDisplay![i])}  ${unitOnly(measureDisplay![i])}',
                    style: GoogleFonts.quicksand(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ]),
              ],
            ),
          )
        ]
      ],
    );
  }

  setMealIngredient({DetailsMealIngredientModel? data, DetailsDrinkIngredientModel? drinkData}) {
    final Map<String, String> ingredientList = widget.type == 'food'
        ? {
            "strIngredient1": data!.meals!.first.strIngredient1 ?? '',
            "strIngredient2": data.meals!.first.strIngredient2 ?? '',
            "strIngredient3": data.meals!.first.strIngredient3 ?? '',
            "strIngredient4": data.meals!.first.strIngredient4 ?? '',
            "strIngredient5": data.meals!.first.strIngredient5 ?? '',
            "strIngredient6": data.meals!.first.strIngredient6 ?? '',
            "strIngredient7": data.meals!.first.strIngredient7 ?? '',
            "strIngredient8": data.meals!.first.strIngredient8 ?? '',
            "strIngredient9": data.meals!.first.strIngredient9 ?? '',
            "strIngredient10": data.meals!.first.strIngredient10 ?? '',
            "strIngredient11": data.meals!.first.strIngredient11 ?? '',
            "strIngredient12": data.meals!.first.strIngredient12 ?? '',
            "strIngredient13": data.meals!.first.strIngredient13 ?? '',
            "strIngredient14": data.meals!.first.strIngredient14 ?? '',
            "strIngredient15": data.meals!.first.strIngredient15 ?? '',
            "strIngredient16": data.meals!.first.strIngredient16 ?? '',
            "strIngredient17": data.meals!.first.strIngredient17 ?? '',
            "strIngredient18": data.meals!.first.strIngredient18 ?? '',
            "strIngredient19": data.meals!.first.strIngredient19 ?? '',
            "strIngredient20": data.meals!.first.strIngredient20 ?? '',
          }
        : {
            "strIngredient1": drinkData!.drinks!.first.strIngredient1 ?? '',
            "strIngredient2": drinkData.drinks!.first.strIngredient2 ?? '',
            "strIngredient3": drinkData.drinks!.first.strIngredient3 ?? '',
            "strIngredient4": drinkData.drinks!.first.strIngredient4 ?? '',
            "strIngredient5": drinkData.drinks!.first.strIngredient5 ?? '',
            "strIngredient6": drinkData.drinks!.first.strIngredient6 ?? '',
            "strIngredient7": drinkData.drinks!.first.strIngredient7 ?? '',
            "strIngredient8": drinkData.drinks!.first.strIngredient8 ?? '',
            "strIngredient9": drinkData.drinks!.first.strIngredient9 ?? '',
            "strIngredient10": drinkData.drinks!.first.strIngredient10 ?? '',
            "strIngredient11": drinkData.drinks!.first.strIngredient11 ?? '',
            "strIngredient12": drinkData.drinks!.first.strIngredient12 ?? '',
            "strIngredient13": drinkData.drinks!.first.strIngredient13 ?? '',
            "strIngredient14": drinkData.drinks!.first.strIngredient14 ?? '',
            "strIngredient15": drinkData.drinks!.first.strIngredient15 ?? '',
          };

    ingredientDisplay = ingredientList.values.where((value) => value != '').toList();
    iLength = ingredientDisplay!.length;
  }

  setMealMeasure({DetailsMealIngredientModel? data, DetailsDrinkIngredientModel? drinkData}) {
    final Map<String, String> measureList = widget.type == 'food'
        ? {
            "strMeasure1": data!.meals!.first.strMeasure1 ?? '',
            "strMeasure2": data.meals!.first.strMeasure2 ?? '',
            "strMeasure3": data.meals!.first.strMeasure3 ?? '',
            "strMeasure4": data.meals!.first.strMeasure4 ?? '',
            "strMeasure5": data.meals!.first.strMeasure5 ?? '',
            "strMeasure6": data.meals!.first.strMeasure6 ?? '',
            "strMeasure7": data.meals!.first.strMeasure7 ?? '',
            "strMeasure8": data.meals!.first.strMeasure8 ?? '',
            "strMeasure9": data.meals!.first.strMeasure9 ?? '',
            "strMeasure10": data.meals!.first.strMeasure10 ?? '',
            "strMeasure11": data.meals!.first.strMeasure11 ?? '',
            "strMeasure12": data.meals!.first.strMeasure12 ?? '',
            "strMeasure13": data.meals!.first.strMeasure13 ?? '',
            "strMeasure14": data.meals!.first.strMeasure14 ?? '',
            "strMeasure15": data.meals!.first.strMeasure15 ?? '',
            "strMeasure16": data.meals!.first.strMeasure16 ?? '',
            "strMeasure17": data.meals!.first.strMeasure17 ?? '',
            "strMeasure18": data.meals!.first.strMeasure18 ?? '',
            "strMeasure19": data.meals!.first.strMeasure19 ?? '',
            "strMeasure20": data.meals!.first.strMeasure20 ?? '',
          }
        : {
            "strMeasure1": drinkData!.drinks!.first.strMeasure1 ?? '',
            "strMeasure2": drinkData.drinks!.first.strMeasure2 ?? '',
            "strMeasure3": drinkData.drinks!.first.strMeasure3 ?? '',
            "strMeasure4": drinkData.drinks!.first.strMeasure4 ?? '',
            "strMeasure5": drinkData.drinks!.first.strMeasure5 ?? '',
            "strMeasure6": drinkData.drinks!.first.strMeasure6 ?? '',
            "strMeasure7": drinkData.drinks!.first.strMeasure7 ?? '',
            "strMeasure8": drinkData.drinks!.first.strMeasure8 ?? '',
            "strMeasure9": drinkData.drinks!.first.strMeasure9 ?? '',
            "strMeasure10": drinkData.drinks!.first.strMeasure10 ?? '',
            "strMeasure11": drinkData.drinks!.first.strMeasure11 ?? '',
            "strMeasure12": drinkData.drinks!.first.strMeasure12 ?? '',
            "strMeasure13": drinkData.drinks!.first.strMeasure13 ?? '',
            "strMeasure14": drinkData.drinks!.first.strMeasure14 ?? '',
            "strMeasure15": drinkData.drinks!.first.strMeasure15 ?? '',
          };

    measureDisplay = measureList.values.where((value) => value != '').toList();
    mLength = measureDisplay!.length;
    if (mLength! < iLength!) {
      measureDisplay!.add('None');
    }
  }

  String changeData(String digit) {
    final RegExp regex = RegExp(r'\d+');
    final Iterable<Match> digitMatches = regex.allMatches(digit);
    if (digitMatches.isNotEmpty) {
      return (double.parse(digitMatches.first.group(0)!) * servingCount).toStringAsFixed(0);
    }
    return '';
  }

  String unitOnly(String unit) {
    final RegExp regex = RegExp(r'[a-zA-Z]+');
    final Iterable<Match> measurementMatches = regex.allMatches(unit);
    if (measurementMatches.isNotEmpty) {
      return measurementMatches.first.group(0)!;
    }
    return '';
  }
}
