import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TabBarWidget extends StatefulWidget {
  final TabBarAttribute field;
  const TabBarWidget({super.key, required this.field});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.field.ontap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.field.isSelected ? const Color.fromRGBO(201, 83, 83, 1) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
          child: Center(
            child: Text(
              widget.field.label,
              style: GoogleFonts.quicksand(
                fontSize: kIsWeb ? 10.sp : 14.sp,
                color: widget.field.isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TabBarAttribute {
  final bool isSelected;
  final String label;
  final Function() ontap;

  const TabBarAttribute({required this.isSelected, required this.label, required this.ontap});
}
