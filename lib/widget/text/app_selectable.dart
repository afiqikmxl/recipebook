// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:recipebook/confiig/size.dart';

class AppSelectableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const AppSelectableText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: style ?? Theme.of(context).textTheme.bodyText1?.apply(fontSizeDelta: isMobile ? 0 : textSize),
      textAlign: textAlign,
    );
  }
}
