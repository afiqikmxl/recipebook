import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

late double textSize;
late double iconSize;
late double screenPadding;
late double screenWidth;
late double screenHeight;

bool isMobile = isMobileSize();

isMobileSize() {
  return screenWidth < 650;
}

class SizeConfig {
  void set(BuildContext context) {
    // MediaQueryData _mediaQueryData = MediaQuery.of(context);
    screenWidth = 100.w;
    screenHeight = 100.h;

    if (screenWidth < 500) {
      textSize = 0;
      iconSize = 7.w;
    } else {
      textSize = 7;
      iconSize = 1.1.w;
    }
    screenPadding = screenPaddingConfiguration(screenWidth);
    isMobile = screenWidth < 650;
  }

  double screenPaddingConfiguration(screenWidth) {
    if (screenWidth < 650) {
      return 5.w;
    } else if (screenWidth < 1024) {
      return 4.w;
    } else {
      return 2.w;
    }
  }
}

class AppPadding {
  final double denominator;

  const AppPadding({
    Key? key,
    this.denominator = 1,
  });

  Widget horizontal() {
    return SizedBox(
      width: 5.w / denominator,
    );
  }

  Widget vertical() {
    return SizedBox(
      height: 5.w / denominator,
    );
  }
}

