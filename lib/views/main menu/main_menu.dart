import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipebook/confiig/color.dart';
import 'package:recipebook/confiig/size.dart';
import 'package:recipebook/views/main%20menu/widget/menu_item.dart';
import 'package:recipebook/widget/text_field/input_field.dart';
import 'package:recipebook/widget/text_field/input_field_attribute.dart';
import 'package:sizer/sizer.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [searchAndCart(kIsWeb), menuSelection(kIsWeb)],
          ),
        ),
      ),
    );
  }

  searchAndCart(bool isWeb) {
    return Container(
      margin: EdgeInsets.only(top: 7.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenPadding / 2, horizontal: screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: GoogleFonts.quicksand(
                    fontSize: isWeb ? 10.sp : 30.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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

  menuSelection(bool isWeb) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.8,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: 50.w,
            height: height * 0.7,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(166, 0, -0, 1),
                borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))),
          ),
          Positioned(
              top: 5.h,
              left: 6.w,
              right: 6.w,
              child: SizedBox(
                width: double.infinity,
                height: 100.h,
                child: Column(
                  children: [
                    MenuItem(
                      image: 'https://picsum.photos/id/292/3852/2556',
                      label: 'Food',
                      onTap: () {
                        context.push(
                          '/home',
                          extra: {"item": 'food'},
                        );
                      },
                      isWeb: isWeb,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    MenuItem(
                      image: 'https://picsum.photos/id/431/5000/3334',
                      label: 'Beverages',
                      onTap: () {
                        context.push(
                          '/home',
                          extra: {"item": 'drink'},
                        );
                      },
                      isWeb: isWeb,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
