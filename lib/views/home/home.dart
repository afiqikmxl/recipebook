import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipebook/confiig/color.dart';
import 'package:recipebook/confiig/size.dart';
import 'package:recipebook/views/home/widget/categories.dart';
import 'package:recipebook/widget/text_field/input_field.dart';
import 'package:recipebook/widget/text_field/input_field_attribute.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  final String? item;
  const HomePage({super.key, required this.item});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            nameHeader(),
            CategoriesWidget(
              selectionItem: widget.item!,
            )
          ],
        ),
      ),
    );
  }

  nameHeader() {
    return Container(
      margin: EdgeInsets.only(top: 7.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenPadding / 2, horizontal: screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      const BackButton(
                        color: Colors.black,
                      ),
                      Text(
                        'Good morning Afiq',
                        style: GoogleFonts.quicksand(
                          fontSize: kIsWeb ? 10.sp : 30.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 5.h,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivering to',
                    style: GoogleFonts.quicksand(
                      fontSize: kIsWeb ? 10.sp : 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Current Location',
                        style: GoogleFonts.quicksand(
                          fontSize: kIsWeb ? 10.sp : 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 5.h,
                        color: const Color.fromRGBO(166, 0, -0, 1),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding, vertical: screenPadding * 2),
            child: InputField(
              field: InputFieldAttribute(
                attribute: 'search',
                controller: TextEditingController(),
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: primary,
                  size: 7.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
