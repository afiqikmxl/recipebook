import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipebook/bloc/home/home_bloc.dart';
import 'package:recipebook/bloc/home/home_event.dart';
import 'package:recipebook/bloc/home/home_state.dart';
import 'package:recipebook/confiig/loading.dart';
import 'package:recipebook/confiig/scroll_behavior_web.dart';
import 'package:recipebook/confiig/size.dart';
import 'package:recipebook/data/repo/repo.dart';
import 'package:recipebook/model/drink_by_category_model.dart';
import 'package:recipebook/model/drink_categories_model.dart';
import 'package:recipebook/model/meal_by_category_model.dart';
import 'package:recipebook/model/meal_categories_model.dart';
import 'package:recipebook/widget/shimmer.dart';
import 'package:sizer/sizer.dart';

class CategoriesWidget extends StatefulWidget {
  final String selectionItem;
  const CategoriesWidget({super.key, required this.selectionItem});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final HomeBloc bloc = HomeBloc(Repo.getInstance());
  CategoriesModel? mealData;
  MealByCategoriesModel? meals;
  CategoriesDrinkModel? drinkData;
  DrinkByCategories? drink;
  String? selected;

  @override
  void initState() {
    showLoading();
    widget.selectionItem == 'food' ? bloc.add(const GetCategoriesEvent()) : bloc.add(const GetDrinkCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is HomeGetCategoriesUpdate) {
          hideLoading();
          if (state.apiResponse.categories!.isNotEmpty) {
            mealData = state.apiResponse;
          } else {}
        }
        if (state is HomeGetMealsByCategoryUpdate) {
          hideLoading();
          if (state.apiResponse.meals!.isNotEmpty) {
            meals = state.apiResponse;
          } else {}
        }
        if (state is HomeGetDrinkCategoriesUpdate) {
          hideLoading();
          if (state.apiResponse.drinks!.isNotEmpty) {
            drinkData = state.apiResponse;
          } else {}
        }
        if (state is HomeGetDrinksByCategoryUpdate) {
          hideLoading();
          if (state.apiResponse.drinks!.isNotEmpty) {
            drink = state.apiResponse;
          } else {}
        } else if (state is LoadingState) {
          if (state.loading == true) {
            showLoading();
          } else {
            hideLoading();
          }
        }
        return widget.selectionItem == 'food'
            ? mealData != null
                ? ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: Column(
                      children: [
                        ScrollConfiguration(
                          behavior: CustomScrollBehavior(),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var item in mealData!.categories!) ...[
                                  categoriesContainer(item.strCategoryThumb!, item.strCategory!, () {
                                    bloc.add(GetMealsByCategoryEvent(item.strCategory!));
                                  })
                                ]
                              ],
                            ),
                          ),
                        ),
                        meals != null
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: screenPadding),
                                      child: Text(
                                        'Popular Food',
                                        style: GoogleFonts.quicksand(
                                          fontSize: kIsWeb ? 10.sp : 35.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const AppPadding(denominator: 2).vertical(),
                                    for (var item in meals!.meals!) ...[
                                      listItem(item.strMealThumb!, item.strMeal!, item.idMeal!),
                                      const AppPadding(denominator: 1).vertical(),
                                    ]
                                  ],
                                ))
                            : const SizedBox()
                      ],
                    ),
                  )
                : const ShimmerContainer(
                    enableShimmer: true,
                  )
            : drinkData != null
                ? ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: Column(
                      children: [
                        ScrollConfiguration(
                          behavior: CustomScrollBehavior(),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var item in drinkData!.drinks!) ...[
                                  categoriesContainer(item.strThumb!, item.strCategory!, () {
                                    bloc.add(GetDrinksByCategoryEvent(item.strCategory!));
                                  })
                                ]
                              ],
                            ),
                          ),
                        ),
                        drink != null
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: screenPadding),
                                      child: Text(
                                        'Popular Beverages',
                                        style: GoogleFonts.quicksand(
                                          fontSize: kIsWeb ? 10.sp : 35.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const AppPadding(denominator: 2).vertical(),
                                    for (var item in drink!.drinks!) ...[
                                      listItem(item.strDrinkThumb!, item.strDrink!, item.idDrink!),
                                      const AppPadding(denominator: 1).vertical(),
                                    ]
                                  ],
                                ))
                            : const SizedBox()
                      ],
                    ),
                  )
                : const ShimmerContainer(
                    enableShimmer: true,
                  );
      },
    );
  }

  categoriesContainer(String imageURL, String label, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: screenPadding),
        child: SizedBox(
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: 40.w,
                  height: kIsWeb ? 50.h : 20.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(imageURL), fit: BoxFit.cover)),
                ),
              ),
              const AppPadding(denominator: 2).vertical(),
              Text(
                label,
                style: GoogleFonts.quicksand(
                  fontSize: kIsWeb ? 10.sp : 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  listItem(String imageURL, String label, String id) {
    return InkWell(
      onTap: () => context.push(
        '/details',
        extra: {"item": imageURL, 'id': id, 'type': widget.selectionItem},
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: kIsWeb ? 60.h : 40.h,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(3, 5),
                  blurRadius: 10,
                  spreadRadius: 3,
                )
              ],
              image: DecorationImage(image: NetworkImage(imageURL), fit: BoxFit.cover),
            ),
          ),
          const AppPadding(denominator: 2).vertical(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenPadding / 4, horizontal: screenPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.quicksand(
                    fontSize: kIsWeb ? 10.sp : 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      size: 4.h,
                      color: const Color.fromRGBO(166, 0, -0, 1),
                    ),
                    Text(
                      (Random().nextDouble() * 5).toStringAsFixed(1),
                      style: GoogleFonts.quicksand(
                        fontSize: kIsWeb ? 10.sp : 14.sp,
                        color: const Color.fromRGBO(166, 0, -0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(${Random().nextInt(200)} ratings)',
                      style: GoogleFonts.quicksand(
                        fontSize: kIsWeb ? 10.sp : 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenPadding / 2),
                      child: Icon(
                        Icons.circle,
                        size: 3.w,
                        color: const Color.fromRGBO(166, 0, -0, 1),
                      ),
                    ),
                    Text(
                      'Pak Mat Western',
                      style: GoogleFonts.quicksand(
                        fontSize: kIsWeb ? 10.sp : 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
