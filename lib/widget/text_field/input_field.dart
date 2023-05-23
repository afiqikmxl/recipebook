// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipebook/confiig/color.dart';
import 'package:recipebook/confiig/size.dart';
import 'package:recipebook/widget/read_only_widget/read_only.dart';
import 'package:recipebook/widget/text/app_selectable.dart';
import 'package:recipebook/widget/text_field/input_field_attribute.dart';
import 'package:sizer/sizer.dart';

class InputField extends StatelessWidget {
  final double? width;
  final InputFieldAttribute field;

  const InputField({
    Key? key,
    required this.field,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<DateTime> rebuild = ValueNotifier(DateTime.now());
    return SizedBox(
      width: width,
      child: Column(
        children: [
          if (field.labelText != null)
            Row(
              children: [
                AppSelectableText(
                  field.labelText ?? '',
                  style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: isMobile ? 0 : textSize),
                ),
              ],
            ),
          const AppPadding(denominator: 4).vertical(),
          ValueListenableBuilder(
            valueListenable: rebuild,
            builder: (context, data, child) {
              return Row(
                children: [
                  Expanded(
                    child: textField(context, () {
                      rebuild.value = DateTime.now();
                    }),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget textField(BuildContext context, Function rebuild) {
    Widget widget = TextFormField(
      readOnly: !field.isEditable,
      style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: textSize),
      cursorColor: Colors.blue,
      obscureText: field.obscureText,
      validator: field.validator,
      focusNode: field.focusNode,
      keyboardType: field.textInputType ??
          ((field.isNumber || field.isCurrency)
              ? TextInputType.number
              : (field.isEmail)
                  ? TextInputType.emailAddress
                  : TextInputType.text),
      decoration: InputDecoration(
        fillColor: field.isEditable ? field.isEditableColor : field.uneditableColor,
        filled: true,
        suffixIcon: field.isPassword
            ? InkWell(
                onTap: () {
                  field.obscureText = !field.obscureText;
                  rebuild();
                },
                child: Icon(
                  field.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: field.obscureText ? const Color(0xFFa3b7c7) : const Color(0xff163567),
                  size: 22,
                ),
              )
            : field.isDatePicker
                ? Padding(
                    padding: EdgeInsets.only(right: isMobile ? screenPadding / 3 : 9),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.calendar,
                          color: primary,
                          size: 24,
                        ),
                        SizedBox(width: isMobile ? 4 : 2),
                        if (field.controller.text != '')
                          Icon(
                            Icons.close,
                            color: Colors.transparent,
                            size: isMobile ? 8.w : null,
                          ),
                      ],
                    ),
                  )
                : field.suffixWidget,
        enabled: field.isEditable,
        prefixIcon: (field.prefixText != null)
            ? Padding(
                padding: EdgeInsets.fromLTRB(
                    isMobile ? screenPadding : screenPadding / 2,
                    isMobile ? screenPadding : (screenPadding / 3),
                    isMobile ? screenPadding : screenPadding / 3,
                    isMobile ? screenPadding : screenPadding / 3),
                child: Text(
                  field.prefixText!,
                  style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: isMobile ? 0 : textSize),
                ),
              )
            : field.prefixIcon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenPadding / 2),
                        child: field.prefixIcon!,
                      ),
                    ],
                  )
                : null,
        hintText: field.hintText,
        errorText: field.errorMessage,
        errorStyle: Theme.of(context).textTheme.subtitle1!.apply(fontSizeDelta: textSize, color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(
            isMobile ? screenPadding : screenPadding / 2,
            isMobile ? screenPadding : screenPadding / 3,
            isMobile ? screenPadding : screenPadding / 3,
            isMobile ? screenPadding : screenPadding / 3),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .apply(fontSizeDelta: isMobile ? 0 : textSize, color: Colors.grey, fontWeightDelta: -2),
      ),
      controller: field.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (String value) {
        if (field.errorMessage != null) {
          field.errorMessage = null;
          rebuild();
        }
        if (field.onChanged != null) {
          field.onChanged!(value);
        }
      },
      inputFormatters: [
        if (field.isCurrency) FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
        if (field.isNumber) FilteringTextInputFormatter.digitsOnly,
        if (field.isAlphaNumericOnly) FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
        LengthLimitingTextInputFormatter(field.maxCharacter),
      ],
      minLines: field.lineNumber,
      maxLines: field.lineNumber,
    );

    return ReadOnly(
      widget,
      isEditable: field.isEditable,
    );
  }
}
