import 'package:flutter/material.dart';

//color pallette
// F9F7F7
// DBE2EF
// 3F72AF
// 112D4E
const primary = Color(0XFF112D4E);
const primaryColors = [
  Color(0XFF112D4E),
  Color(0XFF3F72AF),
];
const secondaryColor = Color(0XFF3F72AF);
const tertiaryColor = Color(0xFFC0C2C2);

//TextFormField
const textFormFieldEditableColor = Color(0xFFEAF2FA);
const textFormFieldUneditableColor = Color(0xFFF5F6F7);

//Shimmer
const shimmerBaseColor = Color(0xFFEEEDED);
const shimmerHighlightColor = Colors.white;

//Card
const cardColor = Color(0XFFf4f5fa);
const containerColor = Color(0xFFDBE2EF);
const shadow = Color(0XFFc2ddf0);

//Text
const textPrimaryColor = Color(0xff163567);
// const textPrimaryColor = Colors.black;
Color? textSecondaryColor = const Color(0xFF78879b);
const textTertiaryColor = Color(0XFF1C61AC);

class ColorConfig {
  List<Color> colorOptions(color) {
    switch (color) {
      case 'primary':
        {
          return [
            const Color(0XFF112D4E),
            const Color(0XFF3F72AF),
          ];
        }

      case 'secondary':
        {
          return [
            const Color.fromARGB(255, 255, 204, 209),
            const Color.fromARGB(255, 229, 115, 115),
            const Color.fromARGB(255, 232, 63, 63),
          ];
        }

      default:
        return [
          const Color(0XFF23286C),
          const Color(0XFF52B3E0),
        ];
    }
  }

  Color statusColor(status) {
    switch (status) {
      case 'success':
        return const Color(0XFF50D142);

      case 'accepted':
        return const Color(0XFF50D142);

      case 'completed':
        return const Color(0XFF50D142);

      case 'active':
        return const Color(0XFF50D142);

      case 'failed':
        return const Color(0XFFDF184A);

      case 'error':
        return const Color(0XFFDF184A);

      case 'progressing':
        return const Color(0xFFDEB627);

      case 'pending':
        return const Color(0xFFDEB627);

      case 'new':
        return const Color(0XFF012869);

      case 'info':
        return const Color(0xFF885DE7);

      case 'expired':
        return const Color(0XFFDF184A);

      default:
        return const Color(0XFF52B3E0);
    }
  }
}
