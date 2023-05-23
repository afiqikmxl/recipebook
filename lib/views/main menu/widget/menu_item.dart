import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipebook/confiig/size.dart';
import 'package:sizer/sizer.dart';

class MenuItem extends StatelessWidget {
  final String image;
  final String label;
  final Function() onTap;
  final bool isWeb;
  const MenuItem({super.key, required this.image, required this.label, required this.onTap, required this.isWeb});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.black12,
      child: SizedBox(
        width: width,
        height: 25.h,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: width * 0.12, right: width * 0.03, top: 2.h, bottom: 2.h),
                width: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3, 7),
                      blurRadius: 5,
                      spreadRadius: 3,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.quicksand(
                          fontSize: isWeb ? 12.sp : 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Random().nextInt(200).toString(),
                        style: GoogleFonts.quicksand(
                          fontSize: isWeb ? 8.sp : 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                bottom: 10,
                left: 0,
                child: Container(
                  width: width * 0.2,
                  height: height * 0.2,
                  margin: EdgeInsets.all(screenPadding / 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                right: -8,
                top: 20,
                bottom: 20,
                child: Container(
                  width: isWeb ? 8.w : width * 0.1,
                  height: height * 0.1,
                  margin: EdgeInsets.all(screenPadding / 2),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-3, 7),
                        blurRadius: 2,
                        spreadRadius: 1,
                      )
                    ],
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: const Color.fromRGBO(166, 0, -0, 1),
                    size: 5.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
