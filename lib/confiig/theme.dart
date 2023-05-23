// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:recipebook/confiig/color.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    canvasColor: const Color(0xffF3F6FB),
    primaryColor: const Color(0xFF86337c),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Inter',
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(color: Colors.white),
      padding: EdgeInsets.zero,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    )),
    textTheme: TextTheme(
      headline1: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
      headline3: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: <Color>[
              Color(0XFFAD1F61),
              Color(0XFF46006A),
            ],
          ).createShader(const Rect.fromLTWH(0.0, 0.0, 500.0, 70.0)),
      ),
      headline4: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: textPrimaryColor),
      bodyText1: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: textPrimaryColor),
      bodyText2: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: textPrimaryColor),
      subtitle1: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: textPrimaryColor),
      subtitle2: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: textPrimaryColor),
      button: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: textPrimaryColor),
      caption: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: textPrimaryColor),
    ),
  );
}

// Dark Them
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF86337c),
    canvasColor: const Color(0xFF141d26),
    scaffoldBackgroundColor: const Color(0xFF141d26),
    cardTheme: CardTheme(
      color: const Color(0xFF141d26),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    backgroundColor: const Color(0xFF141d26),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline1: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline3: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: <Color>[
              Color(0XFFAD1F61),
              Color(0XFF46006A),
            ],
          ).createShader(const Rect.fromLTWH(0.0, 0.0, 500.0, 70.0)),
      ),
      headline4:
          const TextStyle(fontSize: 26.0, fontFamily: 'Uthmanic', fontWeight: FontWeight.w500, color: Colors.white),
      headline5: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
      headline6: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xff163567)),
      bodyText1: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyText2: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.white),
      subtitle1: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: Colors.white),
      subtitle2: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.white),
      button: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
      caption: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    ),
    // textTheme: GoogleFonts.latoTextTheme().copyWith(
    //   bodyText1: TextStyle(color: kBodyTextColorDark),
    //   bodyText2: TextStyle(color: kBodyTextColorDark),
    //   headline4: TextStyle(color: kTitleTextDarkColor, fontSize: 32),
    //   headline1: TextStyle(color: kTitleTextDarkColor, fontSize: 80),
    // ),
  );
}

AppBarTheme appBarTheme = const AppBarTheme(color: Colors.transparent, elevation: 0);
