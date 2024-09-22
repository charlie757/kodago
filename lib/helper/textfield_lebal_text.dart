import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';

// ignore: must_be_immutable
class TextfieldLebalText extends StatelessWidget {
  String title;
  TextfieldLebalText({required this.title});

  @override
  Widget build(BuildContext context) {
    return customText(
      title: title,
      fontSize: 13,
      color: AppColor.blackDarkColor,
      fontWeight: FontWeight.w600,
      fontFamily: FontFamily.interMedium,
    );
  }
}
