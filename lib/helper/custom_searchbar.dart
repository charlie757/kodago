import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/font_family.dart';

class CustomSearchbar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Color backgroundColor;

  const CustomSearchbar(
      {this.controller,
      this.onChanged,
      this.backgroundColor = const Color(0xffECECEC)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(50)),
      child: TextFormField(
        cursorHeight: 20,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              child: Image.asset(
                AppImages.searchIcon,
                height: 20,
                width: 20,
              ),
            ),
            hintText: 'Search...',
            hintStyle: const TextStyle(
                fontSize: 13,
                color: AppColor.grey7DColor,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interRegular)),
        onChanged: onChanged,
      ),
    );
  }
}
